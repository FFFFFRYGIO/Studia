//////////////////////////////////////////////////////////////////////////////////////////
//
// Program wyswietlajacy szescian w rzucie perspektywicznym. Dlugosc boku szescianu
// moze byc interaktywnie zmieniana za pomoca klwiszy '+' i '-'.
//
//////////////////////////////////////////////////////////////////////////////////////////
#include <GL/glut.h>
#include <math.h>


// Definicja stalych
#define WYSOKOSC				11
#define PROMIEN                 8
#define PROMIEN2                8
#define OBSERWATOR_ODLEGLOSC    20.0
#define OBSERWATOR_OBROT_X      20.0
#define OBSERWATOR_OBROT_Y      20.0
#define OBSERWATOR_FOV_Y        30.0
#define PODZIAL_X			    50.0
#define PODZIAL_Y				20.0
#define OBSERWATOR_OBROT_Z      0
#define WYSOKOSC_STOZKA         3
#define PROMIEN_STOZEK          1
#define odlmin                  5.0
#define odlmax                  50.0



float xobs = OBSERWATOR_OBROT_X;
float yobs = OBSERWATOR_OBROT_Y;
float zobs = OBSERWATOR_OBROT_Z;
float odleglosc = OBSERWATOR_ODLEGLOSC;


// Zmienne globalne
double  promien = PROMIEN; // Dlugosc boku szescianu
double  promien2 = PROMIEN2; // Dlugosc boku szescianu
double wysokosc = WYSOKOSC;
int     szerokoscOkna = 1024;
int     wysokoscOkna = 768;
float j = 0, i = 0;
float a, x, y, z;



// Prototypy funkcji
void UstawParametryWidoku(int szer, int wys);
void WyswietlObraz(void);
void ObslugaKlawiatury(unsigned char klawisz, int x, int y);

double Convert(double degree)
{
    double pi = 3.14159265359;
    return (degree * (pi / 180.0));
}
float ilosc = 60;

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja rysujaca szescian o boku "a" w trybie GL_QUAD_STRIP.
// Srodek szescianu znajduje si  w punkcie (0,0,0).
void RysujStozek(double R1, double R2, double H)
{
    // Pocztaek tworzenia ukladu wspolrzednych
    glBegin(GL_LINES);

    // Os X
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(-100.0, 0.0, 0.0);
    glVertex3f(100.0, 0.0, 0.0);

    // Os Y
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, -100.0, 0.0);
    glVertex3f(0.0, 100.0, 0.0);

    // Os Z
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, -100.0);
    glVertex3f(0.0, 0.0, 100.0);

    // Koniec tworzenia ukladu wspolrzednych
    glEnd();

    /*
        #define WYSOKOSC				9.0
        #define PROMIEN                 4.0
        #define PROMIEN2                 2.5
    */

    float alfa = 360.0 / ilosc;
    glColor3f(1.0, 0.0, 0.0);
    glBegin(GL_TRIANGLE_FAN);
    glVertex3f(0, 0, 0);
    for (int i = 0; i * alfa <= 360; i++) {
        //if (i % 2 == 0) glVertex3f(0, 0, 0);
        glVertex3f(R1 * cos(Convert(i * alfa)), 0, R1 * sin(Convert(i * alfa)));
    }
    glEnd();

    glColor3f(0.0, 1.0, 0.0);
    glBegin(GL_TRIANGLES);
    //glVertex3f(R1 * cos(Convert(0)), 0, R1 * sin(Convert(0)));
    //glVertex3f(R2 * cos(Convert(0)), H, R2 * sin(Convert(0)));
    for (int i = 0; i * alfa <= 360; i++) {
        glVertex3f(R1 * cos(Convert(i * alfa)), 0, R1 * sin(Convert(i * alfa)));
        glVertex3f(R2 * cos(Convert(i * alfa)), H, R2 * sin(Convert(i * alfa)));
        glVertex3f(R1 * cos(Convert((i + 1) * alfa)), 0, R1 * sin(Convert((i + 1) * alfa)));

        glVertex3f(R2 * cos(Convert(i * alfa)), H, R2 * sin(Convert(i * alfa)));
        glVertex3f(R1 * cos(Convert((i + 1) * alfa)), 0, R1 * sin(Convert((i + 1) * alfa)));
        glVertex3f(R2 * cos(Convert((i + 1) * alfa)), H, R2 * sin(Convert((i + 1) * alfa)));
    }
    glEnd();

    glColor3f(0.0, 0.0, 1.0);
    glBegin(GL_TRIANGLE_FAN);
    glVertex3f(0, H, 0);
    for (int i = 0; i * alfa <= 360; i++) {
        //if (i % 2 == 0) glVertex3f(0, H, 0);
        glVertex3f(R2 * cos(Convert(i * alfa)), H, R2 * sin(Convert(i * alfa)));
    }
    glEnd();



}

void RysujPolStozka(double R, double H)
{
    float alfa = 360.0 / ilosc;

    // Dolna podstawa
    glColor3f(1.0, 0.0, 0.0);
    glBegin(GL_TRIANGLE_STRIP);
    glVertex3f(0, 0, 0);
    for (int i = 0; i * alfa <= 360; i++) {
        if (i % 2 == 0) glVertex3f(0, 0, 0);
        glVertex3f(R * cos(Convert(i * alfa)), 0, R * sin(Convert(i * alfa)));
    }
    glEnd();

    // Gorna podstawa
    glColor3f(0.0, 1.0, 0.0);
    glBegin(GL_TRIANGLE_STRIP);
    glVertex3f(0, H/2, 0);
    for (int i = 0; i * alfa <= 360; i++) {
        if (i % 2 == 0) glVertex3f(0, H/2, 0);
        glVertex3f(R/2 * cos(Convert(i * alfa)), H/2, R/2 * sin(Convert(i * alfa)));
    }
    glEnd();

    // Sciana boczna
    glColor3f(0.0, 0.0, 1.0);
    glBegin(GL_TRIANGLE_STRIP);
    for (int i = 0; i * alfa <= 360; i++) {
        glVertex3f(R * cos(Convert(i * alfa)), 0, R * sin(Convert(i * alfa)));
        glVertex3f(R / 2 * cos(Convert(i * alfa)), H / 2, R / 2 * sin(Convert(i * alfa)));
    }
    glEnd();


}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja ustawiajaca parametry rzutu perspektywicznego i rozmiary viewportu. Powinna
// by  wywolywana kazdorazowo po zmianie rozmiarow okna programu.
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
    gluPerspective(OBSERWATOR_FOV_Y, (float)szerokoscOkna / (float)wysokoscOkna, 1.0, 1000.0);
}


//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja wyswietlajaca pojedyncza klatke animacji
void WyswietlObraz(void)
{
    // Wyczyszczenie bufora koloru i bufora glebokosci
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Przejscie w tryb modyfikacji macierzy przeksztalcen geometrycznych
    glMatrixMode(GL_MODELVIEW);

    // Zastapienie aktywnej macierzy macierza jednostkowa
    glLoadIdentity();

    // Ustalenie polozenia obserwatora
    glTranslatef(0, 0, -odleglosc);
    glRotatef(xobs, 1, 0, 0);
    glRotatef(yobs, 0, 1, 0);
    glRotatef(zobs, 0, 0, 1);

    // Rysowanie
    //RysujStozek(promien, promien2, wysokosc);
    RysujPolStozka(promien, WYSOKOSC_STOZKA);

    // Przelaczenie buforow ramki
    glutSwapBuffers();
}
float dAlpha;
float segl;

podzialMax = 64;
podzialMin = 4;


//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja obslugi klawiatury
void ObslugaKlawiatury(unsigned char klawisz, int x, int y)
{
    if (klawisz == 'w')
        xobs += 1;
    else if (klawisz == 's')
        xobs -= 1;
    else if (klawisz == 'd')
        yobs -= 1;
    else if (klawisz == 'a')
        yobs += 1;
    else if (klawisz == '1')
        zobs += 1;
    else if (klawisz == '2')
        zobs -= 1;
    else if (klawisz == '4') {
        if (odleglosc > odlmin)
            odleglosc -= 1;
    }
    else if (klawisz == '3') {
        if (odleglosc < odlmax)
            odleglosc += 1;
    }
    else if (klawisz == '+')
    {
        if (ilosc < podzialMax) ilosc++;
    }
    else if (klawisz == '-')
    {
        if (ilosc > podzialMin) ilosc--;
    }


}


//////////////////////////////////////////////////////////////////////////////////////////
// Glowna funkcja programu
int  main(int argc, char** argv)
{
    // Zainicjowanie biblioteki GLUT
    glutInit(&argc, argv);

    // Ustawienie trybu wyswietlania
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);

    // Ustawienie polozenia dolenego lewego rogu okna
    glutInitWindowPosition(100, 100);

    // Ustawienie rozmiarow okna
    glutInitWindowSize(szerokoscOkna, wysokoscOkna);

    // Utworzenie okna
    glutCreateWindow("Stozek");

    // Odblokowanie bufora glebokosci
    glEnable(GL_DEPTH_TEST);

    // Ustawienie wartosci czyszczacej zawartosc bufora glebokosci
    glClearDepth(1000.0);

    // Ustawienie koloru czyszczenia bufora ramki
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);

    // Wlaczenie wyswietlania wielokatow w postaci obrysow (przydatne w celach diagnostycznych).
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    // Zarejestrowanie funkcji (callback) odpowiedzialnej za 
    glutDisplayFunc(WyswietlObraz);

    // Zarejestrowanie funkcji (callback) wywolywanej za kazdym razem kiedy
    // zmieniane sa rozmiary okna
    glutReshapeFunc(UstawParametryWidoku);

    // Zarejestrowanie funkcji wykonywanej gdy okno nie obsluguje
    // zadnych zadan
    glutIdleFunc(WyswietlObraz);

    // Zarejestrowanie funkcji obslugi klawiatury
    glutKeyboardFunc(ObslugaKlawiatury);

    // Obsluga glownej petli programu (wywolywanie zarejestrowanych callbackow
    // w odpowiedzi na odbierane zdarzenia lub obsluga stanu bezczynnosci)
    glutMainLoop(3);

    return 0;
}
