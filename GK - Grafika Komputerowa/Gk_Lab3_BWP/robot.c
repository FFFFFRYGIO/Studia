//////////////////////////////////////////////////////////////////////////////////////////
// Program demonstruje  skladanie transformacji przy modelowaniu zlozonych obiektow
// skladajacych sie z wielu elementow ruchomych (ramie robota). 

#include <GL/glut.h>

/* Definicja stalych */
#define DLUGOSC_BOKU            5.0
#define OBSERWATOR_ODLEGLOSC    50.0
#define OBSERWATOR_OBROT_X      0.0
#define OBSERWATOR_OBROT_Y      90.0
#define OBSERWATOR_OBROT_Z      0.0
#define OBSERWATOR_FOV_Y        30.0
#define pi                      3.1415
////////////////////////////////////////////////////////////////////////////////////////////
/* Zmienne globalne*/
double   bok = DLUGOSC_BOKU; // Długosc boku szescianu
int      szerokoscOkna = 1024;
int      wysokoscOkna = 768;
float    lpodz = 25.0;
GLfloat  Range = OBSERWATOR_ODLEGLOSC;

/* Katy obrotu figury */
GLfloat rotatex = OBSERWATOR_OBROT_X;
GLfloat rotatey = OBSERWATOR_OBROT_Y;
GLfloat rotatez = OBSERWATOR_OBROT_Z;
GLfloat
angle1 = 1,
angle2 = 1,
angle3 = 1;
/* Wpółrzędne położenia obserwatora */

GLdouble eyex = 0;
GLdouble eyey = 0;
GLdouble eyez = 0;

/* Współrzędne punktu w którego kierunku jest zwrócony obserwator*/

GLdouble centerx = 0;
GLdouble centery = 0;
GLdouble centerz = -100;

/* Skladowe koloru */
GLfloat red = 1.0, green = 1.0, blue = 1.0;

double obrotWiezyczki = 0.0, katLufy = 0.0, dObrotWiezyczki = 3.0,
dKatLufy = 2.0, alfa = 0, beta = 0;

/* Prototypy funkcji */
void Rysuj();
void UstawParametryWidoku(int szer, int wys);
void WyswietlObraz(void);
void ObslugaKlawiatury(unsigned char klawisz, int x, int y);
void SpecialKeys(int key, int x, int y);

//////////////////////////////////////////////////////////////////////////////////////////
/*Funkcja rysująca*/
void Rysuj()
{
    GLUquadricObj* kwadryka;


    //korpus
    glPushMatrix();
    glColor3f(0.1, 0.7, 0.2);
    glScalef(10.0, 1.4, 2.0);
    glutSolidCube(1.0);
    glPopMatrix();
    glPushMatrix();
    glColor3f(0.3, 0.1, 0.2);
    glTranslatef(0, 1.1, 0);
    glScalef(10.0, 0.8, 4.0);
    glutSolidCube(1.0);
    glPopMatrix();

    //kola przednie
    kwadryka = gluNewQuadric();
    glPushMatrix();
    glColor3f(0.2, 0.3, 0.5);
    glTranslatef(-3.5, -0.7, 1.0);
    gluCylinder(kwadryka, 1, 1, 1, 30, 6);
    glColor3f(0.3, 0.3, 0.3);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glTranslatef(0, 0, 1);
    glColor3f(0.3, 0.3, 0.3);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glPopMatrix();
    gluDeleteQuadric(kwadryka);

    kwadryka = gluNewQuadric();
    glPushMatrix();
    glTranslatef(-3.5, -0.7, -2.0);
    gluCylinder(kwadryka, 1, 1, 1, 30, 6);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glTranslatef(0, 0, 1);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glPopMatrix();
    gluDeleteQuadric(kwadryka);

    //kola tylne
    kwadryka = gluNewQuadric();
    glPushMatrix();
    glColor3f(1.0, 1.0, 1.0);
    glTranslatef(3.5, -0.7, 1.0);
    gluCylinder(kwadryka, 1, 1, 1, 30, 6);
    glColor3f(0.1, 0.1, 0.1);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glColor3f(0.1, 0.1, 0.1);
    glTranslatef(0, 0, 1);
    glColor3f(0.1, 0.1, 0.1);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glPopMatrix();
    gluDeleteQuadric(kwadryka);

    kwadryka = gluNewQuadric();
    glPushMatrix();
    glTranslatef(3.5, -0.7, -2.0);
    gluCylinder(kwadryka, 1, 1, 1, 30, 6);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glTranslatef(0, 0, 1);
    gluDisk(kwadryka, 0, 1, 10, 10);
    glPopMatrix();
    gluDeleteQuadric(kwadryka);


    //wiezyczka i lufa
    kwadryka = gluNewQuadric();
    glPushMatrix();
    glColor3f(0.1, 0.4, 0.2);
    glTranslatef(1.5, 1.5, 0);
    glRotatef(obrotWiezyczki, 0, 1, 0); // Obrot wieży
    glRotatef(-90, 1, 0, 0);
    gluCylinder(kwadryka, 2.0, 1.0, 1.1, 20, 5);
    glColor3f(0.4, 0.1, 0.2);
    gluDeleteQuadric(kwadryka);
    kwadryka = gluNewQuadric();
    glPushMatrix();
    glColor3f(0.6, 0.1, 0.4);
    glTranslatef(0, 0, 0.55);
    glRotatef(katLufy, 0, 1, 0); // Zmiana kąta obrotu lufy
    glRotatef(-90, 0, 1, 0);
    glColor3f(0.7, 0.1, 0.5);
    gluCylinder(kwadryka, 0.15, 0.15, 4.5, 8, 8);
    glPopMatrix();
    gluDeleteQuadric(kwadryka);
    glPopMatrix();

    // Poczatek tworzenia ukladu wspolrzednych
    glBegin(GL_LINES);

    // Os X
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(-20.0, 0.0, 0.0);
    glVertex3f(20.0, 0.0, 0.0);

    // Os Y
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, -20.0, 0.0);
    glVertex3f(0.0, 20.0, 0.0);

    // Os Z
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, -20.0);
    glVertex3f(0.0, 0.0, 20.0);

    // Koniec tworzenia ukladu wspolrzednych
    glEnd();
    glClearColor(0, 0, 0, 0);
}

//////////////////////////////////////////////////////////////////////////////////////////
/* Funkcja ustawiajaca parametry rzutu perspektywicznego i rozmiary viewportu */
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
    gluPerspective(OBSERWATOR_FOV_Y,
        (float)szerokoscOkna / (float)wysokoscOkna, 1.0, 1000.0);

    // Przejscie w tryb modyfikacji macierzy przeksztalcen geometrycznych
    glMatrixMode(GL_MODELVIEW);

    // Zmiana macierzy znajdujacej sie na wierzcholku stosu na macierz
   //jednostkowa
    glLoadIdentity();

    // Wyswietlanie wielokatow w postaci obrysow.
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
}


//////////////////////////////////////////////////////////////////////////////////////////
/* Funkcja generujaca pojedyncza klatke animacji */
void WyswietlObraz(void)
{
    // Wyczyszczenie bufora ramki i bufora glebokosci
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Powielenie macierzy na wierzcholku stosu
    glPushMatrix();

    // Wyznaczenie polozenia obserwatora (przeksztalcenie uladu wspolrzednych
    // sceny do ukladu wspolrzednych obserwatora).

    glRotatef(10, 0, 0, 0);
    glTranslatef(0, 0, -Range);
    glRotatef(rotatex, 1, 0, 0);
    glRotatef(rotatey, 0, 1, 0);
    glRotatef(rotatez, 0, 0, 1);


    // Generacja obrazu sceny w niewidocznym buforze ramki
    Rysuj();
    // Usuniecie macierzy lezacej na  wierzcholku stosu (powrot do stanu
    // sprzed wywolania funkcji)
    glPopMatrix();

    // Przelaczenie buforow ramki
    glutSwapBuffers();
}


//////////////////////////////////////////////////////////////////////////////////////////
/* Funkcja obslugi klawiatury */
void ObslugaKlawiatury(unsigned char klawisz, int x, int y)
{
    switch (klawisz)
    {
    case '+':
        Range -= 1;
        break;

    case '-':
        Range += 1;
        break;

    case 'd':
        obrotWiezyczki += dObrotWiezyczki;
        break;

    case 'a':
        obrotWiezyczki -= dObrotWiezyczki;
        break;

    case 's':
        if (katLufy >= 0.0)
            katLufy -= dKatLufy;
        break;

    case 'w':
        if (katLufy < 30.0)
            katLufy += dKatLufy;
        break;

    case 27:
        exit(0);
        break;
    }
}
//////////////////////////////////////////////////////////////////////////////////////////
/* Funkcja obslugi zdarzen specjalnych */
void SpecialKeys(int key, int x, int y)
{
    switch (key)
    {
        // kursor w lewo
    case GLUT_KEY_LEFT:
        rotatey -= 1;
        break;

        // kursor w górę
    case GLUT_KEY_UP:
        rotatex -= 1;
        break;

        // kursor w prawo
    case GLUT_KEY_RIGHT:
        rotatey += 1;
        break;

        // kursor w dół
    case GLUT_KEY_DOWN:
        rotatex += 1;
        break;

    case GLUT_KEY_PAGE_UP:
        rotatez += 1;
        break;

    case GLUT_KEY_PAGE_DOWN:
        rotatez -= 1;
        break;

        /* Look AT */
        // kursor w lewo
    case GLUT_KEY_F1:
        eyex += 0.1;
        break;

        // kursor w górę
    case GLUT_KEY_F4:
        eyey -= 0.1;
        break;

        // kursor w prawo
    case GLUT_KEY_F2:
        eyex -= 0.1;
        break;

        // kursor w dół
    case GLUT_KEY_F3:
        eyey += 0.1;
        break;

    case GLUT_KEY_F6:
        eyez -= 0.1;
        break;

        // kursor w dół
    case GLUT_KEY_F5:
        eyez += 0.1;
        break;


    }

    // odrysowanie okna
    UstawParametryWidoku(glutGet(GLUT_WINDOW_WIDTH), glutGet
    (GLUT_WINDOW_HEIGHT));
}

//////////////////////////////////////////////////////////////////////////////////////////
/* Glowna funkcja programu */
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
    glutCreateWindow("LAB_CZOLG");

    // Odblokowanie bufora glebokosci
    glEnable(GL_DEPTH_TEST);

    // Ustawienie funkcji wykonywanej na danych w buforze glebokosci
    glDepthFunc(GL_LEQUAL);

    // Ustawienie wartosci czyszczacej zawartosc bufora glebokosci
    glClearDepth(1000.0);

    // Ustawienie koloru czyszczenia bufora ramki
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);

    // Zarejestrowanie funkcji (callback) wyswietlajacej
    glutDisplayFunc(WyswietlObraz);

    // Zarejestrowanie funkcji (callback) wywolywanej za kazdym razem kiedy
    // zmieniane sa rozmiary okna
    glutReshapeFunc(UstawParametryWidoku);

    // Zarejestrowanie funkcji wykonywanej gdy okno nie obsluguje
    // zadnych zadan
    glutIdleFunc(WyswietlObraz);

    // Zarejestrowanie funkcji obslugi klawiatury
    glutKeyboardFunc(ObslugaKlawiatury);

    // dołączenie funkcji obsługi klawiszy funkcyjnych i klawiszy kursora
    glutSpecialFunc(SpecialKeys);

    // Obsluga glownej petli programu (wywolywanie zarejestrowanych callbackow
    // w odpowiedzi na odbierane zdarzenia lub obsluga stanu bezczynnosci)
    glutMainLoop();

    return 0;
}
