//////////////////////////////////////////////////////////////////////////////////////////
// Program demonstruje  skladanie transformacji przy modelowaniu zlozonych obiektow
// skladajacych sie z wielu elementow ruchomych (ramie robota). 

#include <GL/glut.h>

// Stale wyznaczajace predkosci katowe planety i ksiezyca w stopniach/sek
#define PREDKOSC_KATOWA_PLANETY  1.0
#define PREDKOSC_KATOWA_KSIEZYCA -5.0

// zadanie1
GLfloat odlmin = -40;
GLfloat odlmax = -300;
GLfloat odl = -40;
GLfloat rotObsZ = 0.0;


//wspolczynnik spowolnienia
double spowolnienie = 0.1;


// Wskazniki do wykorzystywanych kwadryk
GLUquadricObj* podstawaSciany;
GLUquadricObj* podstawaDyskG;
GLUquadricObj* przegubSciany;
GLUquadricObj* przegubDyskG;
GLUquadricObj* przegubDyskD;
GLUquadricObj* glowicaSciany;
GLUquadricObj* glowicaDyskG;
GLUquadricObj* glowicaDyskD;

GLfloat rotObsY = 40.0;
GLfloat rotObsX = 40.0;
GLfloat rotPodstawy = 0.0;
GLfloat rotRamienia1 = 40.0;
GLfloat rotRamienia2 = -40.0;
GLfloat rotGlowicy = 20.0;
GLfloat rozUchwytow = 0.5;

// zadanie 3

GLfloat rotPlan1 = 0;
GLfloat rotPlan2 = 0;
GLfloat rotPlan3 = 0;
GLfloat obrPlan = 0;
GLfloat rotKsiezyc = 0;
GLUquadricObj* orbita;


//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja inicjujaca elementy skladowe ramienia robota zamodelowane jako kwadryki
// 
void InicjujRamieRobota(void)
{
    // Zainicjowanie scian bocznych walca bedacego podstawa ramienia
    podstawaSciany = gluNewQuadric();
    gluQuadricDrawStyle(podstawaSciany, GLU_LINE);

    // Zainicjowanie gornej podstawy walca 
    podstawaDyskG = gluNewQuadric();
    gluQuadricDrawStyle(podstawaDyskG, GLU_LINE);



    // Zainicjowanie scian bocznych cylindrycznego przegubu ramienia
    przegubSciany = gluNewQuadric();
    gluQuadricDrawStyle(przegubSciany, GLU_LINE);

    // Zainicjowanie gornej podstawy walca 
    przegubDyskG = gluNewQuadric();
    gluQuadricDrawStyle(przegubDyskG, GLU_LINE);

    // Zainicjowanie dolnej podstawy walca 
    przegubDyskD = gluNewQuadric();
    gluQuadricDrawStyle(przegubDyskD, GLU_LINE);

    // Zainicjowanie scian bocznych cylindra glowicy 
    glowicaSciany = gluNewQuadric();
    gluQuadricDrawStyle(glowicaSciany, GLU_LINE);

    // Zainicjowanie gornej podstawy walca 
    glowicaDyskG = gluNewQuadric();
    gluQuadricDrawStyle(glowicaDyskG, GLU_LINE);

    // Zainicjowanie dolnej podstawy walca 
    glowicaDyskD = gluNewQuadric();
    gluQuadricDrawStyle(glowicaDyskD, GLU_LINE);

}


//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja rysujaca obraz sceny widzianej z biezacej pozycji obserwatora
// Zalozenie: Funkcja glutWireSpehere moze ryswac tylko sfere o promieniu 1  
void RysujRamieRobota(GLfloat obrotPodstawy, GLfloat obrotRamienia1,
    GLfloat obrotRamienia2, GLfloat obrotGlowicy,
    GLfloat rozstawUchwytow)
{

    // Pocztaek tworzenia ukladu wspolrzednych
    glBegin(GL_LINES);

    // Os X
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(-80.0, 0.0, 0.0);
    glVertex3f(80.0, 0.0, 0.0);

    // Os Y
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, -20.0, 0.0);
    glVertex3f(0.0, 20.0, 0.0);

    // Os Z
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, -40.0);
    glVertex3f(0.0, 0.0, 40.0);

    // Koniec tworzenia ukladu wspolrzednych
    glEnd();

    glColor3f(1.0, 1.0, 1.0);



    // Przygotowanie stosu macierzy modelowania
    glPushMatrix();
    // zad2
    // Przesuwanie wiezy
    glTranslatef(0.0, 60.0, 0);
    // Rysowanie podstawy ramienia (cylinder bez dolnej podstawy)
    glPushMatrix();
    // - sciany boczne
    glRotatef(-90.0, 1, 0, 0);
    gluCylinder(podstawaSciany, 3.0, 3.0, 1.0, 20, 4);

    // - gorna podstawa
    glTranslatef(0.0, 0.0, 1.0);
    gluDisk(podstawaDyskG, 0.0, 3.0, 20, 4);
    glPopMatrix();


    // Rysowanie dwoch wspornikow ramienia (prostopadlosciany)
    glPushMatrix();
    glScalef(3.0, 4.0, 1.0);
    glTranslatef(0.0, 3.0 / 4.0, 1.0);
    glutWireCube(1);
    glTranslatef(0.0, 0.0, -2.0);
    glutWireCube(1);
    glPopMatrix();

    // Wyznaczenie osi obrotu ramienia w plaszczyznie pionowej
    glTranslatef(0.0, 4.0, 0.0);

    // Obrot ramienia w plaszczyznie pionowej
    glRotatef(obrotRamienia1, 0, 0, 1);

    // Modelowanie ramienia nr 1
    glPushMatrix();
    glScalef(8.0, 1.0, 1.0);
    glTranslatef(3.5 / 8.0, 0.0, 0.0);
    glutWireCube(1);
    glPopMatrix();

    // Wyznaczenie osi obrotu ramienia 2 w plaszczyznie pionowej
    glTranslatef(7.5, 0.0, 0.0);

    // Obrot ramienia 2 wzgledem ramienia 1
    glRotatef(obrotRamienia2, 0, 0, 1);

    // Modelowanie przegubu (walca z obiema podstawami)
    glPushMatrix();
    // - sciany boczne
    glTranslatef(0.0, 0.0, -0.5);
    gluCylinder(podstawaSciany, 1.0, 1.0, 1.0, 20, 4);

    // - gorna podstawa
    gluDisk(podstawaDyskG, 0.0, 1.0, 20, 4);

    // - dolna podstawa
    glTranslatef(0.0, 0.0, 1.0);
    gluDisk(podstawaDyskG, 0.0, 1.0, 20, 4);
    glPopMatrix();

    // Modelowanie ramienia nr 2
    glPushMatrix();
    glScalef(4.0, 1.0, 1.0);
    glTranslatef(2.0 / 4.0, 0.0, 0.0);
    glutWireCube(1);
    glPopMatrix();

    // Wyznaczenie osi obrotu glowicy
    glTranslatef(4.0, 0.0, 0.0);
    glRotatef(90, 0, 1, 0);
    glRotatef(obrotGlowicy, 0, 0, 1);

    // Modelowanie glowicy (walca z oboma podstawami)
    glPushMatrix();
    // - sciany boczne
    gluCylinder(podstawaSciany, 1.0, 1.0, 1.0, 20, 4);

    // - gorna podstawa
    gluDisk(podstawaDyskG, 0.0, 1.0, 20, 4);

    // - dolna podstawa
    glTranslatef(0.0, 0.0, 1.0);
    gluDisk(podstawaDyskG, 0.0, 1.0, 20, 4);
    glPopMatrix();

    // Modelowanie uchwytu (dwoch prostopadloscianow, ktore sie rozsuwaja i zsuwaja)
    glTranslatef(0.0, 0.0, 1.5);
    glScalef(0.5, 0.5, 2.0);
    glTranslatef(-rozstawUchwytow, 0.0, 0.25);
    glutWireCube(1);
    glTranslatef(rozstawUchwytow * 2.0, 0.0, 0.0);
    glutWireCube(1);


    // Posprzatanie na stosie macierzy modelowania
    glPopMatrix();
}


void RysujWieze() {

    glPushMatrix();
    glTranslatef(0.0, 80.0, 0.0);// zad2
    glRotatef(90, 1, 0, 0);
    glRotatef(270, 1, 0, 0);

    glPushMatrix(); // Czerwony el
    glTranslatef(0, 6.5, 0); // przesuniecie el
    glScalef(4.23, 13, 4.23); // rozmiar el
    glRotatef(45, 0, 1, 0); // rotacja el
    glColor3f(1, 0, 0); // kolor el
    glutSolidCube(1); //rysowanie el
    glPopMatrix();

    glPushMatrix(); // zielony el
    glTranslatef(0, 11.5, 0);
    glScalef(8, 3, 8);
    glColor3f(0, 1, 0);
    glutSolidCube(1);
    glPopMatrix();

    // niebieskie el
    glPushMatrix();
    glTranslatef(3, 14, 3);
    glScalef(2, 2, 2);
    glColor3f(0.0, 0.0, 1.0);
    glutSolidCube(1);
    glPopMatrix();

    glPushMatrix();
    glTranslatef(-3, 14, -3);
    glScalef(2, 2, 2);
    glColor3f(0.0, 0.0, 1.0);
    glutSolidCube(1);
    glPopMatrix();

    glPushMatrix();
    glTranslatef(-3, 14, 3);
    glScalef(2, 2, 2);
    glColor3f(0.0, 0.0, 1.0);
    glutSolidCube(1);
    glPopMatrix();

    glPushMatrix();
    glTranslatef(3, 14, -3);
    glScalef(2, 2, 2);
    glColor3f(0.0, 0.0, 1.0);
    glutSolidCube(1);
    glPopMatrix();

    glPopMatrix();
    // usuniecie podstawy
}

void inicjujUklad() {
    orbita = gluNewQuadric();
    gluQuadricDrawStyle(orbita, GLU_LINE);
}

void RysujUklad() {


    // UKLAD

    glPushMatrix();

    // rysowanie slonca
    glColor3f(1.0, 1.0, 0.0);
    glPushMatrix();
    glRotatef(-90, 1, 0, 0);// bieguny bry³y na osi z
    gluDisk(orbita, 20, 20, 40, 1); // zaznaczenie orbity
    glPushMatrix();
    glRotatef(30, 1, 0, 0);////////////////////////////
    gluDisk(orbita, 60, 60, 40, 1); //zaznaczenie orbity

    //glRotatef(30, 1, 0, 0);

    glPopMatrix();
    glPushMatrix();
    glRotatef(-15, 1, 0, 0);
    gluDisk(orbita, 80, 80, 40, 1); //zaznaczenie orbity
    glPopMatrix();
    glScalef(5.0, 5.0, 5.0);
    glutWireSphere(1.0, 20.0, 20.0);

    glPopMatrix();

    // Rysowanie planety okr¹¿aj¹cej s³oñce po orbicie o promieniu 60 z prêdkoœci¹ 0.15 stopieñ na klatkê CCW promieñ 6
    glPushMatrix();
    glRotatef(30, 1, 0, 0);
    glColor3f(0.0, 0.5, 0.0);
    glRotatef(rotPlan2 * spowolnienie, 0, 1, 0);

    //glRotatef(30, 1, 0, 0);

    glTranslatef(0.0, 0.0, 60.0);
    glPushMatrix();
    glRotatef(obrPlan, 0, 1, 0);
    glRotatef(-90.0, 1, 0, 0);/////////////////
    glScalef(6.0, 6.0, 6.0);
    glutWireSphere(1.0, 20.0, 20.0);
    glPopMatrix();
    glPopMatrix();

    // Rysowanie planety okr¹¿aj¹cej s³oñce po orbicie o promieniu 80 z prêdkoœci¹ 0.25 stopieñ na klatkê CW promieñ 4
    glPushMatrix();
    glRotatef(-15, 1, 0, 0);
    glColor3f(0.0, 1.0, 0.5);
    glRotatef(rotPlan3 * spowolnienie, 0, 1, 0);

    //glRotatef(-15, 1, 0, 0);

    glTranslatef(0.0, 0.0, 80.0);
    glPushMatrix();
    glRotatef(obrPlan, 0, 1, 0);
    glRotatef(-90.0, 1, 0, 0);
    glScalef(4.0, 4.0, 4.0);
    glutWireSphere(1.0, 20.0, 20.0);
    glPopMatrix();
    glPopMatrix();


    // Rysowanie planety okr¹¿aj¹cej s³oñce po orbicie o r = 20 z prêdkoœci¹ 1 stopieñ na klatkê
    //(kierunek CW) 
    glColor3f(0.0, 1.0, 1.0);
    glRotatef(rotPlan1 * spowolnienie, 0, 1, 0);
    glTranslatef(0.0, 0.0, 20.0);

    glPushMatrix();
    glRotatef(obrPlan, 0, 1, 0);
    glRotatef(-90.0, 1, 0, 0);
    glScalef(2.0, 2.0, 2.0);
    glutWireSphere(1.0, 20.0, 20.0);
    gluDisk(orbita, 2.5, 2.5, 40, 1); //zaznaczenie orbity 2,5 nie 5 - glut? liczy od zewnatrz//////
    glPopMatrix();

    // Rysowanie ksiê¿yca okr¹¿aj¹cego planetê po orbicie o r =  5 z prêdkoœci¹ 0.5 stopni na klatkê (kierunek CCW) 
    glColor3f(0.0, 0.0, 1.0);
    glRotatef(-rotKsiezyc * spowolnienie, 0, 1, 0);
    glRotatef(-90.0, 1, 0, 0);
    glTranslatef(5.0, 0.0, 0.0);
    glScalef(0.5, 0.5, 0.5);
    glutWireSphere(1.0, 20, 20);
    glPopMatrix();

    //korekcja zmiennych w pêtli RysujScene
    rotPlan1 -= 0.25;
    rotPlan2 += 0.15;
    rotPlan3 -= 0.25;
    obrPlan += 1;
    rotKsiezyc += 0.5;

}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja generujaca pojedyncza klatke animacji
void WyswietlObraz(void)
{

    // Wyczyszczenie bufora ramki i bufora glebokosci
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Powielenie macierzy na wierzcholku stosu 
    glPushMatrix();

    // Wyznaczenie polozenia obserwatora
    // Przeksztalcenie uladu wspolrzednych 
    // sceny do ukladu wspolrzednych obserwatora. 
    // wyznaczamy odleg³oœæ obserwatora od obiektu
    // 

    //zadanie1
    glTranslatef(0, 0, odl);
    glRotatef(rotObsX, 1, 0, 0);
    glRotatef(rotObsY, 0, 1, 0);
    // zadanie1
    glRotatef(rotObsZ, 0, 0, 1);

    // Generacja obrazu sceny w niewidocznym buforze ramki
    RysujRamieRobota(rotPodstawy, rotRamienia1, rotRamienia2, rotGlowicy, rozUchwytow);

    // zadanie2
    RysujWieze();

    // zadanie3

    RysujUklad();

    // Usuniecie macierzy lezacej na  wierzcholku stosu (powrot do stanu
    // sprzed wywolania funkcji)
    glPopMatrix();

    // Przelaczenie buforow ramki
    glutSwapBuffers();


}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja ustawiajaca parametry rzutu perspektywicznego i rozmiary viewportu
void UstawParametryWidoku(int szerokosc, int wysokosc)
{
    // Ustawienie parametrow viewportu
    glViewport(0, 0, szerokosc, wysokosc);

    // Przejscie w tryb modyfikacji macierzy rzutowania
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(40.0, (float)szerokosc / (float)wysokosc, 1.0, 1000.0);

    // Przejscie w tryb modyfikacji macierzy przeksztalcen geometrycznych
    glMatrixMode(GL_MODELVIEW);

    // Zmiana macierzy znajdujacej sie na wierzcholku stosu na macierz jednostkowa 
    glLoadIdentity();
}

//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja klawiszy specjalnych
void ObslugaKlawiszySpecjalnych(int klawisz, int x, int y)
{
    // zadanie1
    switch (klawisz)
    {
    case GLUT_KEY_UP:
        rotObsX += 1.0; // dodawanie k¹ta na osi OX
        break;

    case GLUT_KEY_DOWN:
        rotObsX -= 1.0; // odejmowanie k¹ta na osi 0X
        break;

    case GLUT_KEY_LEFT:
        rotObsY -= 1.0; // odejmowanie k¹ta na osi 0Y
        break;

    case GLUT_KEY_RIGHT:
        rotObsY += 1.0; // dodawanie k¹ta na osi OY
        break;
    }
}
//////////////////////////////////////////////////////////////////////////////////////////
// Funkcja obslugi klawiatury
void ObslugaKlawiatury(unsigned char klawisz, int x, int y)
{

    switch (klawisz)
    {
    case '2':
        rotRamienia1 = (rotRamienia1 < 90.0) ? rotRamienia1 + 1.0 : rotRamienia1;
        break;

    case '@':
        rotRamienia1 = (rotRamienia1 > 0.0) ? rotRamienia1 - 1.0 : rotRamienia1;
        break;

    case '3':
        rotRamienia2 = (rotRamienia2 < 0.0) ? rotRamienia2 + 1.0 : rotRamienia2;
        break;

    case '#':
        rotRamienia2 = (rotRamienia2 > -90.0) ? rotRamienia2 - 1.0 : rotRamienia2;
        break;

    case '4':
        rotGlowicy = (rotGlowicy < 360.0) ? rotGlowicy + 1.0 : rotGlowicy;
        break;

    case '$':
        rotGlowicy = (rotGlowicy > 0.0) ? rotGlowicy - 1.0 : rotGlowicy;
        break;

    case '5':
        rozUchwytow = (rozUchwytow < 1.5) ? rozUchwytow + 0.1 : rozUchwytow;
        break;

    case '%':
        rozUchwytow = (rozUchwytow > 0.5) ? rozUchwytow - 0.1 : rozUchwytow;
        break;
        // zadanie1
    case '+': // przybli¿anie
        odl = (odl < odlmin) ? odl + 1.0 : odl;
        break;
    case '-': // oddalamie
        odl = (odl > odlmax) ? odl - 1.0 : odl;
        break;
    case '*': // po osi Z
        rotObsZ += 1.0;
        break;
    case '/': // po osi Z
        rotObsZ -= 1.0;
        break;

    }

    if (klawisz == 27)
        exit(0);
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
    glutInitWindowSize(400, 400);

    // Utworzenie okna
    glutCreateWindow("Robot");

    // Odblokowanie bufora glebokosci
    glEnable(GL_DEPTH_TEST);

    // Ustawienie funkcji wykonywanej na danych w buforze glebokosci
    glDepthFunc(GL_LEQUAL);

    // Ustawienie wartosci czyszczacej zawartosc bufora glebokosci
    glClearDepth(1000.0);

    // Ustawienie koloru czyszczenia bufora ramki
    glClearColor(0.0, 0.0, 0.0, 0.0);

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

    // Zarejestrowanie funkcji obslugi klawiszy specjalnych
    glutSpecialFunc(ObslugaKlawiszySpecjalnych);


    // Zainicjowanie kwadryk tworzacych ramie robota
    InicjujRamieRobota();

    // zad3
    inicjujUklad();

    // Obsluga glownej petli programu (wywolywanie zarejestrowanych callbackow
    // w odpowiedzi na odbierane zdarzenia lub obsluga stanu bezczynnosci)
    glutMainLoop();

    return 0;
}
