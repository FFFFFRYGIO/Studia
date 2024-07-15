using Microsoft.Speech.Recognition;
using Microsoft.Speech.Synthesis;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Lab2_2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        static bool speechOn = true;
        static SpeechSynthesizer pTTS = new SpeechSynthesizer();
        static SpeechRecognitionEngine pSRE;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void WindowLoaded(object sender, RoutedEventArgs e)
        {
            try
            {
                pTTS.SetOutputToDefaultAudioDevice();
                pTTS.SpeakAsync("Witam w kalkulatorze");
                // Ustawienie języka rozpoznawania:
                CultureInfo ci = new CultureInfo("pl-PL");

                // Utworzenie "silnika" rozpoznawania:
                pSRE = new SpeechRecognitionEngine(ci);

                // Ustawienie domyślnego urządzenia wejściowego:
                pSRE.SetInputToDefaultAudioDevice();

                // Przypisanie obsługi zdarzenia realizowanego po rozpoznaniu wypowiedzi zgodnej z gramatyką:
                pSRE.SpeechRecognized += PSRE_SpeechRecognized;
                // -------------------------------------------------------------------------
                // Budowa gramatyki numer 1 - POLECENIA SYSTEMOWE
                // Budowa gramatyki numer 1 - określenie komend:
                Choices stopChoice = new Choices();
                stopChoice.Add("Stop");
                stopChoice.Add("Pomoc");

                // Budowa gramatyki numer 1 - definiowanie składni gramatyki:
                GrammarBuilder buildGrammarSystem = new GrammarBuilder();
                buildGrammarSystem.Append(stopChoice);

                // Budowa gramatyki numer 1 - utworzenie gramatyki:
                Grammar grammarSystem = new Grammar(buildGrammarSystem); //
                                                                         // -------------------------------------------------------------------------
                                                                         // Budowa gramatyki numer 2 - POLECENIA DLA PROGRAMU
                                                                         // Budowa gramatyki numer 2 - określenie komend:
                Choices chNumbers = new Choices(); //możliwy wybór słów
                string[] numbers = new string[] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
                chNumbers.Add(numbers);

                Choices chOperations = new Choices(); //możliwy wybór słów
                string[] operations = new string[] { "plus", "minus", "razy", "podzielić przez" };
                chOperations.Add(operations);

                // Budowa gramatyki numer 2 - definiowanie składni gramatyki:
                GrammarBuilder grammarProgram = new GrammarBuilder();
                grammarProgram.Append("Oblicz");
                grammarProgram.Append(chNumbers);
                grammarProgram.Append(chOperations);
                grammarProgram.Append(chNumbers);

                // Budowa gramatyki numer 2 - utworzenie gramatyki:
                Grammar g_WhatIsXplusY = new Grammar(grammarProgram); //gramatyka
                                                                      // -------------------------------------------------------------------------
                                                                      // Załadowanie gramatyk:
                pSRE.LoadGrammarAsync(g_WhatIsXplusY);
                pSRE.LoadGrammarAsync(grammarSystem);
                // Ustaw rozpoznawanie przy wykorzystaniu wielu gramatyk:
                pSRE.RecognizeAsync(RecognizeMode.Multiple);
                // -------------------------------------------------------------------------
                Console.WriteLine("\nAby zakonczyć działanie programu powiedz 'STOP'\n");
                // while (speechOn == true) {; } //pętla w celu uniknięcia zamknięcia programu
                Console.WriteLine("\tWCIŚNIJ <ENTER> aby wyjść z programu\n");
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
        }

        Button GetButtonFromNumber(int number)
        {
            switch (number)
            {
                case 0: return btn0;
                case 1: return btn1;
                case 2: return btn2;
                case 3: return btn3;
                case 4: return btn4;
                case 5: return btn5;
                case 6: return btn6;
                case 7: return btn7;
                case 8: return btn8;
                case 9: return btn9;
                default: return null;
            }
        }

        Button GetButtonFromOperation(string operation)
        {
            switch (operation)
            {
                case "plus": return btnSum;
                case "minus": return btnSubtraction;
                case "razy": return btnMultiplication;
                case "podzielić przez": return btnDivision;
                default: return null;
            }
        }

        private void ColorButtons(int num1, int num2, string operation)
        {
            Button btnNum1 = GetButtonFromNumber(num1);
            Button btnNum2 = GetButtonFromNumber(num2);
            Button btnOperation = GetButtonFromOperation(operation);

            var greenBrush = new SolidColorBrush(Color.FromRgb(0, 128, 0));

            if (btnNum1 != null)
                btnNum1.Background = greenBrush;

            if (btnNum2 != null)
                btnNum2.Background = greenBrush;

            if (btnOperation != null)
                btnOperation.Background = greenBrush;
        }

        private void ClearBtnColors()
        {
            var greyBrush = new SolidColorBrush(Color.FromRgb(192, 192, 192));

            btn0.Background = greyBrush;
            btn1.Background = greyBrush;
            btn2.Background = greyBrush;
            btn3.Background = greyBrush;
            btn4.Background = greyBrush;
            btn5.Background = greyBrush;
            btn6.Background = greyBrush;
            btn7.Background = greyBrush;
            btn8.Background = greyBrush;
            btn9.Background = greyBrush;

            btnSum.Background = greyBrush;
            btnSubtraction.Background = greyBrush;
            btnMultiplication.Background = greyBrush;
            btnDivision.Background = greyBrush;
        }

        private void PSRE_SpeechRecognized(object sender, SpeechRecognizedEventArgs e)
        {
            ClearBtnColors();

            string txt = e.Result.Text;
            string comments;
            float confidence = e.Result.Confidence;
            comments = String.Format("ROZPOZNANO (wiarygodność: {0:0.000}): '{1}'",
           e.Result.Confidence, txt);
            Console.WriteLine(comments);
            if (confidence > 0.60)
            {
                if (txt.IndexOf("Stop") >= 0)
                {
                    speechOn = false;
                }
                else if (txt.IndexOf("Pomoc") >= 0)
                {
                    pTTS.SpeakAsync("Składnia polecenia: Oblicz liczba plus liczba. Na przykład: dwa plus trzy");
                }
                else if ((txt.IndexOf("Oblicz") >= 0) && (txt.IndexOf("plus") >= 0) && (speechOn == true))
                {
                    string[] words = txt.Split(' ');
                    int liczba1 = int.Parse(words[1]);
                    int liczba2 = int.Parse(words[3]);
                    int suma = liczba1 + liczba2;
                    comments = String.Format("\tOBLICZONO: {0} + {1} = {2}",
                    liczba1, liczba2, suma);
                    Console.WriteLine(comments);
                    pTTS.SpeakAsync("Wynik działania to: " + suma);

                    ColorButtons(liczba1, liczba2, "plus");
                    btnResult.Content = String.Format("{0} + {1} = {2}", liczba1, liczba2, suma);
                }
                else if ((txt.IndexOf("Oblicz") >= 0) && (txt.IndexOf("minus") >= 0) && (speechOn == true))
                {
                    string[] words = txt.Split(' ');
                    int liczba1 = int.Parse(words[1]);
                    int liczba2 = int.Parse(words[3]);
                    int roznica = liczba1 - liczba2;
                    comments = String.Format("\tOBLICZONO: {0} - {1} = {2}",
                    liczba1, liczba2, roznica);
                    Console.WriteLine(comments);

                    if (roznica < 0)
                        pTTS.SpeakAsync("Wynik działania to: minus " + roznica * -1);
                    else
                        pTTS.SpeakAsync("Wynik działania to: " + roznica);

                    ColorButtons(liczba1, liczba2, "minus");
                    btnResult.Content = String.Format("{0} - {1} = {2}", liczba1, liczba2, roznica);
                }
                else if ((txt.IndexOf("Oblicz") >= 0) && (txt.IndexOf("razy") >= 0) && (speechOn == true))
                {
                    string[] words = txt.Split(' ');
                    int liczba1 = int.Parse(words[1]);
                    int liczba2 = int.Parse(words[3]);
                    int iloczyn = liczba1 * liczba2;
                    comments = String.Format("\tOBLICZONO: {0} * {1} = {2}",
                    liczba1, liczba2, iloczyn);
                    Console.WriteLine(comments);
                    pTTS.SpeakAsync("Wynik działania to: " + iloczyn);

                    ColorButtons(liczba1, liczba2, "razy");
                    btnResult.Content = String.Format("{0} * {1} = {2}", liczba1, liczba2, iloczyn);
                }
                else if ((txt.IndexOf("Oblicz") >= 0) && (txt.IndexOf("podzielić przez") >= 0) && (speechOn == true))
                {
                    string[] words = txt.Split(' ');
                    int liczba1 = int.Parse(words[1]);
                    int liczba2 = int.Parse(words[4]);
                    if (liczba2 == 0)
                    {
                        comments = String.Format("\tNie można dzielić prez 0!");
                        Console.WriteLine(comments);
                        pTTS.SpeakAsync("Nie można dzielić przez zero!");

                        btnResult.Content = String.Format("Error");
                    }
                    else
                    {
                        float iloraz = (float)liczba1 / liczba2;
                        comments = String.Format("\tOBLICZONO: {0} / {1} = {2}",
                        liczba1, liczba2, iloraz);
                        Console.WriteLine(comments);
                        pTTS.SpeakAsync("Wynik działania to: " + iloraz);

                        ColorButtons(liczba1, liczba2, "podzielić przez");
                        btnResult.Content = String.Format("{0} / {1} = {2}", liczba1, liczba2, iloraz);
                    }
                }
            }
            else
            {
                comments = String.Format("\tNISKI WSPÓŁCZYNNIK WIARYGODNOŚCI - powtórz polecenie");

                Console.WriteLine(comments);
                pTTS.SpeakAsync("Proszę powtórzyć");
            }
        }
    }
}
