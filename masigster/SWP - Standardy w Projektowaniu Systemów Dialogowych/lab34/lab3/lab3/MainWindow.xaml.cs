using Microsoft.Speech.Recognition;
using Microsoft.Speech.Synthesis;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Windows;
using System.Xml.Linq;

namespace Lab3
{
    public partial class MainWindow : Window
    {
        static bool speechOn = true;
        static SpeechSynthesizer pTTS = new SpeechSynthesizer();
        static SpeechRecognitionEngine pSRE;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                // Inicjalizacja pTTS
                pTTS.SetOutputToDefaultAudioDevice();
                pTTS.SpeakAsync("Witam w formularzu lodziarni");
                CultureInfo ci = new CultureInfo("pl-PL");
                pSRE = new SpeechRecognitionEngine(ci);
                pSRE.SetInputToDefaultAudioDevice();
                pSRE.SpeechRecognized += PSRE_SpeechRecognized;
                // Wczytanie gramatyki w języku SRGS
                pSRE.LoadGrammarAsync(new Grammar("../../../Gramatyka.xml"));
                pSRE.RecognizeAsync(RecognizeMode.Multiple);
            }
            catch (Exception ex)
            {
                pTTS.Speak(ex.Message);
            }
        }

        // Działania po wykryciu mowy
        private void PSRE_SpeechRecognized(object sender, SpeechRecognizedEventArgs e)
        {
            string txt = e.Result.Text;
            float confidence = e.Result.Confidence;
            // Wybór odpowiedniego polecenia
            if (confidence > 0.60)
            {
                if (txt.IndexOf("Stop") >= 0)
                {
                    Application.Current.Shutdown();
                }
                else if (txt.IndexOf("Pomoc") >= 0)
                {
                    pTTS.SpeakAsync("Przykładowe zamówienie: gałka jeden waniliowy, gałka dwa śmietankowy, wafelek stożkowy, polewa czekoladowa, posypka orzechowa");
                }
                else if (txt.IndexOf("Wyślij formularz") >= 0)
                {
                    ShowForm();
                }
                else if ((txt.IndexOf("Gałka") >= 0) && (speechOn == true))
                {
                    if ((txt.IndexOf("jeden") >= 1) && (speechOn == true))
                    {
                        // Wprowadzenie wypowiedzianej opcji do odpowiedniego pola
                        string galka_jeden = txt.Split(' ')[txt.Split(' ').Length - 1];
                        pole_galka_jeden.Text = galka_jeden;
                        // Poinformowanie o wybranej opcji
                        pTTS.SpeakAsync("Wybrana gałka jeden: " + galka_jeden);
                    }
                    else if ((txt.IndexOf("dwa") >= 1) && (speechOn == true))
                    {
                        // Wprowadzenie wypowiedzianej opcji do odpowiedniego pola
                        string galka_dwa = txt.Split(' ')[txt.Split(' ').Length - 1];
                        pole_galka_dwa.Text = galka_dwa;
                        // Poinformowanie o wybranej opcji
                        pTTS.SpeakAsync("Wybrana gałka dwa: " + galka_dwa);
                    }
                    else
                    {
                        pTTS.SpeakAsync("Proszę powtórzyć");
                    }
                }
                else if ((txt.IndexOf("Wafelek") >= 0) && (speechOn == true))
                {
                    string wafelek = txt.Split(' ')[txt.Split(' ').Length - 1];
                    pole_wafelek.Text = wafelek;
                    pTTS.SpeakAsync("Wybrany wafelek: " + wafelek);
                }
                else if ((txt.IndexOf("Polewa") >= 0) && (speechOn == true))
                {
                    string polewa = txt.Substring(txt.IndexOf(' ') + 1).TrimStart();
                    pole_polewa.Text = polewa;
                    pTTS.SpeakAsync("Wybrana polewa: " + polewa);
                }
                else if ((txt.IndexOf("Posypka") >= 0) && (speechOn == true))
                {
                    string posypka = txt.Substring(txt.IndexOf(' ') + 1).TrimStart();
                    pole_posypka.Text = posypka;
                    pTTS.SpeakAsync("Wybrana posypka: " + posypka);
                }
            }
            else
            {
                pTTS.SpeakAsync("Proszę powtórzyć");
            }
        }

        // Sprawdzanie formularza
        private void ShowForm()
        {
            // Sprawdzanie gramatyki dla każdego pola
            List<string> errorMessages = new List<string>();
            if (!CheckGrammar("galka", pole_galka_jeden.Text))
            {
                errorMessages.Add("Proszę podać smak gałki na przykład śmietankowy (gałka pierwsza)");
            }
            if (!CheckGrammar("galka", pole_galka_dwa.Text))
            {
                errorMessages.Add("Proszę podać smak gałki na przykład śmietankowy (gałka druga)");
            }
            if (!CheckGrammar("wafelek", pole_wafelek.Text))
            {
                errorMessages.Add("Proszę podać rodzaj wafelka na przykład słodki");
            }
            if (!CheckGrammar("polewa", pole_polewa.Text))
            {
                errorMessages.Add("Proszę podać rodzaj polewy na przykład czekoladowy");
            }
            if (!CheckGrammar("posypka", pole_posypka.Text))
            {
                errorMessages.Add("Proszę podać posypkę na przykład kokosowa");
            }

            if (errorMessages.Any())
            {
                string fullErrorMessage = string.Join("\n", errorMessages);
                pTTS.SpeakAsync(fullErrorMessage);
            }
            else
            {
                // Poprawnie wypełniony formularz
                pTTS.SpeakAsync("Formularz wysłany");
                // Wiadomość w okienku podsumowania
                string message = $"Gałka jeden: {pole_galka_jeden.Text}\n" +
                                 $"Gałka dwa: {pole_galka_dwa.Text}\n" +
                                 $"Wafelek: {pole_wafelek.Text}\n" +
                                 $"Polewa: {pole_polewa.Text}\n" +
                                 $"Posypka: {pole_posypka.Text}";
                // Wyświetlenie okienka z podsumowaniem
                MessageBox.Show(message, "Podsumowanie formularza", MessageBoxButton.OK, MessageBoxImage.Information);
                // Czyszczenie pól tekstowych
                pole_galka_jeden.Text = "";
                pole_galka_dwa.Text = "";
                pole_wafelek.Text = "";
                pole_polewa.Text = "";
                pole_posypka.Text = "";
            }
        }

        // Sprawdzanie czy wartość znajduje się w odpowiedniej regule w gramatyce
        private bool CheckGrammar(string fieldName, string value)
        {
            try
            {
                // Wczytanie pliku gramatyki
                XDocument doc = XDocument.Load("../../../Gramatyka.xml");
                XNamespace ns = "http://www.w3.org/2001/06/grammar";
                // Pobranie odpowiedniej reguły
                XElement rule = doc.Descendants(ns + "rule").FirstOrDefault(r => (string)r.Attribute("id") == fieldName);
                if (rule != null)
                {
                    // Szukanie wartości w regule
                    if (rule.Descendants(ns + "item").Any(item => (string)item == value))
                    {
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.WriteLine("Błąd podczas sprawdzania gramatyki: " + ex.Message);
            }
            return false;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            ShowForm();
        }
    }
}
