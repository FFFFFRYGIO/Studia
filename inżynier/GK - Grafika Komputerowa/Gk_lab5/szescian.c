#include <math.h>
#include <string.h>
#include <stdio.h>
#include <gl/glut.h>


// Definicja stalych
#define KROK_FLOAT          0.1
#define X_OFFSET_SWIATLO    10
#define Y_OFFSET_SWIATLO    120
#define X_OFFSET_MAT        10
#define Y_OFFSET_MAT        220
#define X_OFFSET_OBIEKT     10
#define Y_OFFSET_OBIEKT     300
#define ID_MENU_SWIATLA     0
#define ID_MENU_MATERIALU   1
#define LPOZ_MENU_SWIATLA   6
#define LPOZ_MENU_MATERIALU 5
#define M_PI            3.1415926535
#define WYSOKOSC_STOZEK     3
#define PROMIEN_STOZEK      1

double  promien;           // Promien walca
double  wysokosc;          // Wysokosc walca
int     sIndeks;           // Wybrana pozycja w tablicy parametrow swiatla
int     mIndeks;           // Wybrana pozycja w tablicy parametrow materialu
int     menu;              // Identyfikator wybranego menu (menu swiatla lub menu materialu) 
int     malowanie = 0;
int     cieniowanie = 0;
int     normalne = 0;
int     wlacznik1 = 0;
int     wlacznik2 = 0;
int     szerokoscOkna = 1200;
int     wysokoscOkna = 900;
int		l_podz = 4;

GLfloat kat_orbityX = 0;
GLfloat kat1 = 0;
GLfloat promien_reflektora = 20;
GLfloat predkosc_orbity = 0.25;
GLUquadricObj* Okrag;

GLint     kolor = 1;
GLdouble h = 3.0;
GLdouble r = 2.0;
GLdouble i = 0.0;
GLdouble j = 0.0;
GLdouble M = 12.0;
GLdouble n = 64.0;
GLdouble n2 = 64.0;
GLfloat rotObsY = 315.0;
GLfloat rotObsX = 20.0;
GLfloat rotObsZ = 0.0;
GLfloat odleglosc = -8.0;
GLdouble szybkosc_swiatla = 0.0;
GLdouble nachylenie_swiatla = 0.0;
GLdouble promien_swiatla = 2.0;
GLdouble kat_swiatla = 7.0;


// Tablica parametrow swiatla
GLfloat swiatlo[6][4];
GLfloat swiatlo2[6][4];

// Tablica parametrow materialu z jakiego wykonany jest walec
GLfloat material[6][4];
GLfloat material2[6][4];
GLfloat material3[6][4];


// Prototypy funkcji
void UstawDomyslneWartosciParametrow(void);
void UstawKolorPozycji(int m, int indeks);
void WlaczOswietlenie(void);
void DefiniujMaterial(void);
void UstawParametryOswietlenia(int indeks, char operacja);
void UstawParametryMaterialu(int indeks, char operacja);
void UstawParametryWidoku(int szer, int wys);
void WyswietlObraz(void);
void ObslugaKlawiatury(unsigned char klawisz, int x, int y);
void ObslugaKlawiszySpecjalnych(int klawisz, int x, int y);

// Konwersja stopni na radiany
double Convert(double degree)
{
    double pi = 3.14159265359;
    return (degree * (pi / 180.0));
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja ustawiajaca domyslne parametry walca, materialu i zrodla swiatla
void UstawDomyslneWartosciParametrow(void)
{

    GLfloat param_materialu[6][4] = { // fioletowy blyszczacy (widziany w bialym swietle)
        {0.7, 0.0, 0.7, 1.0},   // [0] wspolczynnik odbicia swiatla otoczenia
        {0.5, 0.5, 0.5, 1.0},   // [1] wspolczynnik odbicia swiatla rozproszonego
        {1.0, 1.0, 1.0, 1.0},   // [2] wspolczynnik odbicia swiatla lustrzanego
        {128.0, 0.0, 0.0, 0.0}, // [3] polysk
        {0.0, 0.0 , 0.0, 0.0},  // [4] kolor swiatla emitowanego
    };

    GLfloat param_materialu2[6][4] = { // zielony matowy (widziany w bialym swietle)
        {0.0, 0.4, 0.0, 1.0},   // [0] wspolczynnik odbicia swiatla otoczenia
        {0.1, 0.1, 0.1, 1.0},   // [1] wspolczynnik odbicia swiatla rozproszonego
        {0.0, 0.0, 0.0, 1.0},   // [2] wspolczynnik odbicia swiatla lustrzanego
        {0.0, 0.0, 0.0, 0.0},   // [3] polysk
        {0.0, 0.0, 0.0, 0.0},   // [4] kolor swiatla emitowanego
    };

    GLfloat param_materialu3[6][4] = { // jadeit
        {0.135000, 0.222500, 0.157500, 0.950000},   // [0] wspolczynnik odbicia swiatla otoczenia
        {0.540000, 0.890000, 0.630000, 0.950000},   // [1] wspolczynnik odbicia swiatla rozproszonego
        {0.316228, 0.316228, 0.316228, 0.950000},   // [2] wspolczynnik odbicia swiatla lustrzanego
        {12.8, 0.0, 0.0, 0.0},                      // [3] polysk 
        {0.0, 0.0, 0.0, 0.0},                       // [4] kolor swiatla emitowanego
    };

    GLfloat param_swiatla[6][4] = { // reflektor bialy ruchomy
        {1.0, 1.0, 1.0, 1.0},   // [0] otoczenie
        {1.0, 1.0, 1.0, 1.0},   // [1] rozproszenie
        {1.0, 1.0, 1.0, 1.0},   // [2] lustrzane
        {0.0, 0.0, 0.0, 1.0},   // [3] polozenie
        {0.0, 0.0, 0.0, 0.0},   // [4] kierunek swiecenia
        {30.0, 0.0, 0.0, 0.0}   // [5] tlumienie katowe swiatla
    };

    GLfloat param_swiatla2[6][4] = { // kierunkowe zolte
        {1.0, 1.0, 0.0, 0.7},       // [0] otoczenie
        {1.0, 1.0, 0.0, 0.7},       // [1] rozproszenie
        {1.0, 1.0, 0.0, 0.7},       // [2] lustrzane
        {-10.0, 10.0, 10.0, 1.0},   // [3] polozenie
        {0.0, 0.0, 0.0, 0.0},       // [4] kierunek swiecenia
        {0.0, 0.0, 0.0, 0.0}        // [5] tlumienie katowe swiatla
    };

     // Skopiowanie zawartosci tablic param_* do tablic globalnych
    memcpy(material, param_materialu, LPOZ_MENU_MATERIALU * 4 * sizeof(GLfloat));
    memcpy(swiatlo, param_swiatla, LPOZ_MENU_SWIATLA * 4 * sizeof(GLfloat));
    memcpy(material2, param_materialu2, LPOZ_MENU_MATERIALU * 4 * sizeof(GLfloat));
    memcpy(swiatlo2, param_swiatla2, LPOZ_MENU_SWIATLA * 4 * sizeof(GLfloat));
    memcpy(material3, param_materialu3, LPOZ_MENU_MATERIALU * 4 * sizeof(GLfloat));


    // Pozostale parametry
    sIndeks = 0;        // Wybrana pozycja w tablicy parametrow swiatla
    mIndeks = 0;        // Wybrana pozycja w tablicy parametrow materialu
    menu = ID_MENU_SWIATLA;

    glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER, GL_TRUE);
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja ustawia kolor dla pozycji <indeks> w  menu <m>. Aktualnie wybrana pozycja 
// jest rysowana w kolorze zoltym.
void UstawKolorPozycji(int m, int indeks)
{
    if (m == menu)
        if ((m == ID_MENU_SWIATLA) && (indeks == sIndeks)
            || (m == ID_MENU_MATERIALU) && (indeks == mIndeks))

            // Pozycja podswietlona wyswietlana jest w kolkorze zoltym
            glColor3f(1.0, 1.0, 0.0);
        else

            // Pozostale na bialo
            glColor3f(1.0, 1.0, 1.0);
}


//Wlaczenie  oswietlenia sceny
void WlaczOswietlenie(void)
{

    GLfloat pozycja_swiatla[] = { promien_swiatla * cos(Convert(kat_swiatla)) , 0.01 , promien_swiatla * sin(Convert(kat_swiatla)), 1.0 };
    GLfloat kierunek_swiatla[] = { -(promien_swiatla * cos(Convert(kat_swiatla))) , 0.0 , -(promien_swiatla * sin(Convert(kat_swiatla))), 0.0 };


    // Odblokowanie zerowego zrodla swiatla
    if (wlacznik1)glEnable(GL_LIGHT0);
    else  glDisable(GL_LIGHT0);
    if (wlacznik2) glEnable(GL_LIGHT1);
    else  glDisable(GL_LIGHT1);


    // Inicjowanie swiatla 1 + mala sferka

    glPushMatrix();
    glRotatef(nachylenie_swiatla, 1, 0, 0);
    glTranslatef(promien_swiatla * cos(Convert(kat_swiatla)), 0.01, promien_swiatla * sin(Convert(kat_swiatla)));
    glColor3f(0.0, 0.0, 0.0);
    glutSolidSphere(0.1, 20, 20);

    glLightfv(GL_LIGHT0, GL_AMBIENT, swiatlo[0]);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, swiatlo[1]);
    glLightfv(GL_LIGHT0, GL_SPECULAR, swiatlo[2]);
    glLightfv(GL_LIGHT0, GL_POSITION, pozycja_swiatla); // pozycja swiatla
    glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, kierunek_swiatla);
    glLightf(GL_LIGHT0, GL_SPOT_EXPONENT, swiatlo[5][0]);
    // glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, swiatlo[6][0]);
    // glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, swiatlo[7][0]);
    // glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, swiatlo[8][0]);
    // glLightf(GL_LIGHT0, GL_QUADRATIC_ATTENUATION, swiatlo[9][0]);

    glPopMatrix();

    // Inicjowanie  wiat a 2 + ma a sferka

    glPushMatrix();
    glTranslatef(-10.0, 10.0, 10.0);
    glColor3f(0.0, 0.0, 0.0);
    //glutSolidSphere(0.4, 20, 20);
    glPopMatrix();

    glLightfv(GL_LIGHT1, GL_AMBIENT, swiatlo2[0]);
    glLightfv(GL_LIGHT1, GL_DIFFUSE, swiatlo2[1]);
    glLightfv(GL_LIGHT1, GL_SPECULAR, swiatlo2[2]);
    glLightfv(GL_LIGHT1, GL_POSITION, swiatlo2[3]);
    glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, swiatlo2[4]);
    glLightf(GL_LIGHT1, GL_SPOT_EXPONENT, swiatlo2[5][0]);
    // glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, swiatlo2[6][0]);
    // glLightf(GL_LIGHT1, GL_CONSTANT_ATTENUATION, swiatlo2[7][0]);
    // glLightf(GL_LIGHT1, GL_LINEAR_ATTENUATION, swiatlo2[8][0]);
    // glLightf(GL_LIGHT1, GL_QUADRATIC_ATTENUATION, swiatlo2[9][0]);
}


//////////////////////////////////////////////////////////////////////////////////////////
// Zdefiniowanie walasciwosci materialu walca na podstawie zapisanych w tablcy 'material'
// parametrow (material obowiazuje tylko do scian skierowanych przodem do obserwatora)
void Material(void)
{
    glMaterialfv(GL_FRONT, GL_AMBIENT, material[0]);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, material[1]);
    glMaterialfv(GL_FRONT, GL_SPECULAR, material[2]);
    glMaterialfv(GL_FRONT, GL_SHININESS, material[3]);
    glMaterialfv(GL_FRONT, GL_EMISSION, material[4]);
}

void Material2(void)
{
    glMaterialfv(GL_FRONT, GL_AMBIENT, material2[0]);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, material2[1]);
    glMaterialfv(GL_FRONT, GL_SPECULAR, material2[2]);
    glMaterialfv(GL_FRONT, GL_SHININESS, material2[3]);
    glMaterialfv(GL_FRONT, GL_EMISSION, material2[4]);
}

void Material3(void)
{
    glMaterialfv(GL_FRONT, GL_AMBIENT, material3[0]);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, material3[1]);
    glMaterialfv(GL_FRONT, GL_SPECULAR, material3[2]);
    glMaterialfv(GL_FRONT, GL_SHININESS, material3[3]);
    glMaterialfv(GL_FRONT, GL_EMISSION, material3[4]);
}

void RysujTekstRastrowy(void* font, char* tekst)
{
    int i;

    for (i = 0; i < (int)strlen(tekst); i++)
        glutBitmapCharacter(font, tekst[i]);
}

void RysujNakladke(void)//slasz piekne menu, nie trzaeba interaktywnie
{
    char buf[255];
    // Zmiana typu rzutu z perspektywicznego na ortogonalny
    glMatrixMode(GL_PROJECTION);
    glPushMatrix();
    glLoadIdentity();
    glOrtho(0.0, szerokoscOkna, 0.0, wysokoscOkna, -100.0, 100.0);

    // Modelowanie sceny 2D (zawartosci nakladki)
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
    glLoadIdentity();

    // Zablokowanie oswietlenia (mialoby ono wplyw na kolor tekstu)
    glDisable(GL_LIGHTING);

    // Okreslenie koloru tekstu
    glColor3f(1.0, 1.0, 1.0);

    // RYSOWANIE MENU 

    glColor3f(1.0, 1.0, 1.0);

    sprintf(buf, "Menu");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 60);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- / - zmien material, obecnie material %d", kolor);
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 70);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- v/c - liczba podzialow pionowych +/- (%.f)", n);
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 80);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- b/n - liczba podzialow poziomych +/- (%.f)", n2);
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 90);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (cieniowanie == 0) sprintf(buf, "- j - cieniowanie (plaskie)");
    else  sprintf(buf, "- j - cieniowanie (gladkie)");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 100);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (malowanie == 0) sprintf(buf, "- k - wypelnienie - ON");
    else  sprintf(buf, "- k - wypelnienie - OFF");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 110);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (normalne == 1) sprintf(buf, "- l - malowanie normalnych (wektorow) - ON");
    else  sprintf(buf, "- l - malowanie normalnych (wektorow) - OFF");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 120);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- q/w - odleglosc od obiektu +/-");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 140);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- strzalki - obroty  osi x i y");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 160);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "Swiatla:");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 180);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (wlacznik1 == 1) sprintf(buf, "- h - swiatlo 1 - ON");
    else sprintf(buf, "- h - swiatlo 1 - OFF");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 190);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (wlacznik2 == 1) sprintf(buf, "- g - swiatlo 2 - ON");
    else sprintf(buf, "- g - swiatlo 2 - OFF");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 200);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- e/r - promien swiatla 1 +/- (%.f)", promien_swiatla);
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 220);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    if (szybkosc_swiatla == 0)      sprintf(buf, "- u/i - predkosc swiatla 1 +/- (1)");
    else if (szybkosc_swiatla == 1) sprintf(buf, "- u/i - predkosc swiatla 1 +/- (0.5)");
    else if (szybkosc_swiatla == 2) sprintf(buf, "- u/i - predkosc swiatla 1 +/- (0.125)");
    else                            sprintf(buf, "- u/i - predkosc swiatla 1 +/- (0)");
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 230);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    sprintf(buf, "- t/y - nachylenie swiatla 1 +/- (%.f)", nachylenie_swiatla);
    glRasterPos2i(X_OFFSET_OBIEKT, Y_OFFSET_OBIEKT - 240);
    RysujTekstRastrowy(GLUT_BITMAP_8_BY_13, buf);

    // Przywrocenie macierzy sprzed wywolania funkcji
    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
    glMatrixMode(GL_MODELVIEW);
    glPopMatrix();

    // Odblokowanie oswietlenia
    glEnable(GL_LIGHTING);
}

//////////////////////////////////////////////////////////////////////////////////////////
// STOZEK // Dla tresci WYSOKOSC_STOZEK = 3 PROMIEN_STOZEK = 1
void RysujStozek(double R, double H)
{
    float dalfa = 360.0 / (double)n;

    double h = H / 2; // Wysokosc
    double r_d = R; // Promien dolu
    double r_g = R / 2; // Promien gory

    int podz_poziom = n2;
    int podz_pion = n;

    double x, y, z, r_t;
    double kat_bocznych_wektorow = atan(r_d / h);

    // Dolna podstawa
    glColor3f(0.0, 1.0, 0.0);
    glBegin(GL_TRIANGLE_STRIP);
    glVertex3f(0, 0, 0);
    for (int i = 0; i * dalfa <= 360; i++) {
        if (i % 2 == 0) {
            glNormal3f(0.0, -1.0, 0.0);
            glVertex3f(0, 0, 0);
        }
        glNormal3f(0.0, -1.0, 0.0);
        glVertex3f(R * cos(Convert(i * dalfa)), 0, R * sin(Convert(i * dalfa)));
        
    }
    glEnd();

    // Gorna podstawa
    glColor3f(0.0, 1.0, 0.0);
    glBegin(GL_TRIANGLE_STRIP);
    glVertex3f(0, H / 2, 0);
    for (int i = 0; i * dalfa <= 360; i++) {
        if (i % 2 == 0) {
            glNormal3f(0.0, 1.0, 0.0);
            glVertex3f(0, H / 2, 0);
        }
        glNormal3f(0.0, 1.0, 0.0);
        glVertex3f(R / 2 * cos(Convert(i * dalfa)), H / 2, R / 2 * sin(Convert(i * dalfa)));
        
    }
    glEnd();

    // Sciany boczne
    glColor3f(0.0, 0.0, 1.0);
    glBegin(GL_TRIANGLE_STRIP);
    for (y = 0, r_t = r_d; (y <= h); y += h / podz_poziom, r_t -= ((r_d - r_g) / podz_poziom))
    {
        for (float i = 0; i <= 2.0001 * M_PI; i += M_PI / (podz_pion / 2)) {
            x = r_t * cos(i);
            z = r_t * sin(i);

            glNormal3f(cos(i) * cos(kat_bocznych_wektorow), sin(kat_bocznych_wektorow), sin(i) * cos(kat_bocznych_wektorow));
            glVertex3f(x, y, z);

            x = (r_t - ((r_d - r_g) / podz_poziom) < r_g) ? (r_g)*cos(i + M_PI / (podz_pion / 2)) : (r_t - ((r_d - r_g) / podz_poziom)) * cos(i + M_PI / (podz_pion / 2));
            z = (r_t - ((r_d - r_g) / podz_poziom) < r_g) ? (r_g)*sin(i + M_PI / (podz_pion / 2)) : (r_t - ((r_d - r_g) / podz_poziom)) * sin(i + M_PI / (podz_pion / 2));

            glNormal3f(cos(i + M_PI / (podz_pion / 2)) * cos(kat_bocznych_wektorow), sin(kat_bocznych_wektorow), sin(i + M_PI / (podz_pion / 2)) * cos(kat_bocznych_wektorow));
            glVertex3f(x, (y + h / podz_poziom > h) ? h : (y + h / podz_poziom), z);
        }
    }
    glEnd();

    // Rysowanie wektorow
    if (normalne == 1) {
        for (i = 0; i <= n; ++i)
        {
            glBegin(GL_LINES); // Dolna podstawa
            glVertex3f(((r_d) / 2) * cos(Convert(i * dalfa + (dalfa / 2))), 0, ((r_d) / 2) * sin(Convert(i * dalfa + (dalfa / 2))));
            glVertex3f(((r_d) / 2) * cos(Convert(i * dalfa + (dalfa / 2))), -1, ((r_d) / 2) * sin(Convert(i * dalfa + (dalfa / 2))));
            glEnd();

            glBegin(GL_LINES); // Gorna podstawa
            glVertex3f(((r_g) / 2) * cos(Convert(i * dalfa + (dalfa / 2))), h, ((r_g) / 2) * sin(Convert(i * dalfa + (dalfa / 2))));
            glVertex3f(((r_g) / 2) * cos(Convert(i * dalfa + (dalfa / 2))), h + 1, ((r_g) / 2) * sin(Convert(i * dalfa + (dalfa / 2))));
            glEnd();
        }
        
        // Sciany boczne
        for (y = 0, r_t = r_d; (y < h + h / podz_poziom); y += h / podz_poziom, r_t -= ((r_d - r_g) / podz_poziom))
        {
            for (float i = 0; i <= 2.0001 * M_PI; i += M_PI / (podz_pion / 2)) {
                x = r_t * cos(i);
                z = r_t * sin(i);

                glBegin(GL_LINES);
                glVertex3f(x, y, z);
                glVertex3f(x + cos(i) * cos(kat_bocznych_wektorow), y + sin(kat_bocznych_wektorow), z + sin(i) * cos(kat_bocznych_wektorow));
                glEnd();

            }
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja ustawiajaca parametry rzutu perspektywicznego i rozmiary viewportu
void UstawParametryWidoku(int szer, int wys)
{
    // Zapamietanie wielkosci widoku
    szerokoscOkna = szer;
    wysokoscOkna = wys;

    // Ustawienie parametrow viewportu
    glViewport(0, 0, szerokoscOkna, wysokoscOkna);

    // Przejscie w tryb modyfikacji macierzy rzutowania
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(40.0, (float)szerokoscOkna / (float)wysokoscOkna, 1.0, 1000.0);

    // Przejscie w tryb modyfikacji macierzy przeksztalcen geometrycznych
    glMatrixMode(GL_MODELVIEW);

    // Zmiana macierzy znajdujacej sie na wierzcholku stosu na macierz jednostkowa 
    glLoadIdentity();
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja generujaca pojedyncza klatke animacji
void WyswietlObraz(void)
{
    // Wyczyszczenie bufora ramki i bufora glebokosci
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Okreslenie wielkosci widoku, wlaczenie rzutowania perspektywicznego
    // i zainicjowanie stosu macierzy modelowania
    UstawParametryWidoku(szerokoscOkna, wysokoscOkna);

    // Ustalenie polozenia obserwatora
    glTranslatef(0, 0, odleglosc);
    glRotatef(rotObsX, 1, 0, 0);
    glRotatef(rotObsY, 0, 1, 0);
    glRotatef(rotObsZ, 0, 0, 1);
    double a = 5;

    // Generacja obrazu
    RysujStozek(PROMIEN_STOZEK, WYSOKOSC_STOZEK);

    WlaczOswietlenie();

    // Narysowanie tekstow z opisem parametrow oswietlenia i materialu
    RysujNakladke();

    // Przelaczenie buforow ramki
    glutSwapBuffers();

    // Wy wietlanie siatki/materialow 
    if (malowanie == 1) glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    else glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

    if (cieniowanie == 1) glShadeModel(GL_SMOOTH);
    else glShadeModel(GL_FLAT);

    if (szybkosc_swiatla == 0) kat_swiatla = kat_swiatla + 0.5;
    else if (szybkosc_swiatla == 1) kat_swiatla = kat_swiatla + 0.25;
    else if (szybkosc_swiatla == 2) kat_swiatla = kat_swiatla + 0.125;

    // Wybor materialu
    for (i = 1; i <= 3; i++)
    {
        if (kolor == 1) { Material(); }
        else if (kolor == 2) { Material2(); }
        else { Material3(); }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja obslugi klawiatury
void ObslugaKlawiszySpecjalnych(int klawisz, int x, int y)
{
    switch (klawisz)
    {
    case GLUT_KEY_UP:
        rotObsX = (rotObsX < 10000.0) ? rotObsX + 1.0 : rotObsX;
        break;
    case GLUT_KEY_DOWN:
        rotObsX = (rotObsX > -10000) ? rotObsX - 1.0 : rotObsX;
        break;
    case GLUT_KEY_LEFT:
        rotObsY = (rotObsY > -10000.0) ? rotObsY - 1.0 : rotObsY;
        break;
    case GLUT_KEY_RIGHT:
        rotObsY = (rotObsY < 10000.0) ? rotObsY + 1.0 : rotObsY;
        break;
    }
}
void ObslugaKlawiatury(unsigned char klawisz, int x, int y)
{
    switch (klawisz)
    {
    case '/': // Zmiana materialu
        if (kolor < 3) kolor++; else kolor = 1;
        break;

    case 'z': // Nachylenie
        rotObsZ = (rotObsZ < 10000.0) ? rotObsZ + 1.0 : rotObsZ;
        break;

    case 'x': // Nachylenie w druga strone
        rotObsZ = (rotObsZ > -10000.0) ? rotObsZ - 1.0 : rotObsZ;
        break;

    case 'q': // Przybliz widok
        odleglosc = (odleglosc < -5.0) ? odleglosc + 1.0 : odleglosc;
        break;

    case 'w': // Oddal widok
        odleglosc = (odleglosc > -150.0) ? odleglosc - 1.0 : odleglosc;
        break;

    case 'c': // Zwieksz ilosc podzialow pionowych
        n = (n < 64.0) ? n + 2.0 : n;
        break;

    case 'v': // Zmniejsz ilosc podzialow pionowych
        n = (n > 4.0) ? n - 2.0 : n;
        break;

    case 'b': // Zwieksz ilosc podzialow poziomych
        n2 = (n2 < 64.0) ? n2 + 2.0 : n2;
        break;

    case 'n': // Zmniejsz ilosc podzialow poziomych
        n2 = (n2 > 4.0) ? n2 - 2.0 : n2;
        break;

    case 'h': // Wlacz/wylacz swiatlo 1
        wlacznik1 = (wlacznik1 > 0) ? 0 : 1;
        break;

    case 'g': // Wlacz/wylacz swiatlo 2
        wlacznik2 = (wlacznik2 > 0) ? 0 : 1;
        break;

    case 'e': // Oddal zrodlo swiatla 1, zwieksz promien
        promien_swiatla = (promien_swiatla < 120.0) ? promien_swiatla + 1.0 : promien_swiatla;
        break;

    case 'r': // Przybliz zrodlo swiatla 1, zmniejsz promien
        promien_swiatla = (promien_swiatla > 2.0) ? promien_swiatla - 1.0 : promien_swiatla;
        break;

    case 't': // Nachylenie zrodla swiatla 1
        if (nachylenie_swiatla < 360) nachylenie_swiatla++; else nachylenie_swiatla = 0;
        break;

    case 'y': // Nachylenie zrodla swiatla 2 w druga strone
        if (nachylenie_swiatla > 0) nachylenie_swiatla--; else nachylenie_swiatla = 360;
        break;

    case 'i': // Zmniejsz predkosc zrodla swiatla 1
        szybkosc_swiatla = (szybkosc_swiatla < 3.0) ? szybkosc_swiatla + 1.0 : szybkosc_swiatla;
        break;

    case 'u': // Zwieksz predkosc zrodla swiatla 1
        szybkosc_swiatla = (szybkosc_swiatla > 0.0) ? szybkosc_swiatla - 1.0 : szybkosc_swiatla;
        break;

    case 'j': // Przelacznik cieniowania
        cieniowanie = (cieniowanie > 0) ? 0 : 1;
        break;

    case 'k': // Przelacznik rysowanie linii - wypelnienia
        malowanie = (malowanie > 0) ? 0 : 1;
        break;

    case 'l': // Przelacznik pokazywania wektorow
        normalne = (normalne == 1) ? 0 : 1;
        break;
    }
}


//////////////////////////////////////////////////////////////////////////////////////////
// Glowna funkcja programu
int  main(int argc, char** argv)
{
    // Zainicjowanie biblioteki GLUT
    glutInit(&argc, argv);

    // Ustawienie trybu wyswietlania
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);

    // Ustawienie polozenia dolenego lewego rogu okna
    glutInitWindowPosition(100, 100);

    // Ustawienie rozmiarow okna
    glutInitWindowSize(szerokoscOkna, wysokoscOkna);

    // Utworzenie okna
    glutCreateWindow("Radoslaw Relidzynski WCY20IJ1S1 Oswietlony stozek");

    // Zarejestrowanie funkcji obslugi klawiatury
    glutKeyboardFunc(ObslugaKlawiatury);

    // Zarejestrowanie funkcji obslugi klawiszy specjalnych
    glutSpecialFunc(ObslugaKlawiszySpecjalnych);

    // Odblokowanie bufora glebokosci
    glEnable(GL_DEPTH_TEST);

    // Ustawienie funkcji wykonywanej na danych w buforze glebokosci
    glDepthFunc(GL_LEQUAL);

    // Ustawienie wartosci czyszczacej zawartosc bufora glebokosci
    glClearDepth(1000.0);

    // Odblokowanie wykonywania operacji na skladowych "alfa"
    glEnable(GL_BLEND);

    // Wybor funkcji mieszajacej kolory
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    // Ustawienie koloru czyszczenia bufora ramki
    glClearColor(0.0, 0.0, 0.0, 0.0);

    // Zarejestrowanie funkcji (callback) wywolywanej za kazdym razem kiedy
    // zmieniane sa rozmiary okna
    glutReshapeFunc(UstawParametryWidoku);

    // Ustawienie domyslnych wartosci parametrow
    UstawDomyslneWartosciParametrow();

    // Zarejestrowanie funkcji (callback) wyswietlajacej
    glutDisplayFunc(WyswietlObraz);

    // Zarejestrowanie funkcji wykonywanej gdy okno nie obsluguje
    // zadnych zadan
    glutIdleFunc(WyswietlObraz);

    // Obsluga glownej petli programu (wywolywanie zarejestrowanych callbackow
    // w odpowiedzi na odbierane zdarzenia lub obsluga stanu bezczynnosci)
    glutMainLoop();

    return 0;
}