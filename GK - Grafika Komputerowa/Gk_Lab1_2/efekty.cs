//-----------------------------------------------//
// Autor: Rados³aw Relidzyñski, grupa WCY20IJ1S1 //
// Data wykonania: 3.11.2022 r.                  //
//-----------------------------------------------//
namespace Graf_kom
{
    public partial class f_graf_kom
    {
        public void Zmien_obraz_hls()
        {
            System.Drawing.Color pixel;
            double sum = 0;
            double brightness = 0;
            double contrast = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    int l_hls = (System.Math.Max(System.Math.Max(pixel.R, pixel.G), pixel.B) + System.Math.Min(System.Math.Min(pixel.R, pixel.G), pixel.B)) / 2;

                    //pixel = System.Drawing.Color.FromArgb(pixel.R, pixel.G, pixel.B);
                    pixel = System.Drawing.Color.FromArgb(l_hls, l_hls, l_hls);
                    sum += l_hls;

                    //--------------------------------------//

                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            brightness = sum / (L * K);
            sum = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    int l_hls = (System.Math.Max(System.Math.Max(pixel.R, pixel.G), pixel.B) + System.Math.Min(System.Math.Min(pixel.R, pixel.G), pixel.B)) / 2;
                    double x = l_hls - brightness;
                    sum += x * x;
                    //pixel = System.Drawing.Color.FromArgb(pixel.R, pixel.G, pixel.B);
                    //pixel = System.Drawing.Color.FromArgb(l_hls, l_hls, l_hls);
                    //SuppressMessageAttribute += l_hls;

                    //--------------------------------------//

                    //m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            contrast = System.Math.Sqrt(sum / (L * K));
            label3.Text = "jasnosc = " + System.Math.Round(((double)brightness / 255) * 100, 0) + "%";
            label4.Text = "kontrast = " + System.Math.Round(((double)contrast / 127.5) * 100, 0) + "%";



            SetBitMap(ref m_ekran);
        }
        public void Zmien_obraz_hsv()
        {
            System.Drawing.Color pixel;
            double sum = 0;
            double brightness = 0;
            double contrast = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    int l_hsv = System.Math.Max(System.Math.Max(pixel.R, pixel.G), pixel.B);

                    //pixel = System.Drawing.Color.FromArgb(pixel.R, pixel.G, pixel.B);
                    pixel = System.Drawing.Color.FromArgb(l_hsv, l_hsv, l_hsv);
                    sum += l_hsv;

                    //--------------------------------------//

                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            brightness = sum / (L * K);
            sum = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    int l_hsv = System.Math.Max(System.Math.Max(pixel.R, pixel.G), pixel.B);
                    double x = l_hsv - brightness;
                    sum += x * x;

                }
            contrast = System.Math.Sqrt(sum / (L * K));
            label3.Text = "jasnosc = " + System.Math.Round(((double)brightness / 255) * 100, 0) + "%";
            label4.Text = "kontrast = " + System.Math.Round(((double)contrast / 127.5) * 100, 0) + "%";

            SetBitMap(ref m_ekran);
        }
        public void Zmien_obraz_avg()
        {
            System.Drawing.Color pixel;
            double sum = 0;
            double brightness = 0;
            double contrast = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    int avg = (pixel.R + pixel.G + pixel.B) / 3;

                    pixel = System.Drawing.Color.FromArgb(avg, avg, avg);
                    sum += avg;

                    //--------------------------------------//

                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            brightness = sum / (L * K);
            sum = 0;

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    double avg = (double)(pixel.R + pixel.G + pixel.B) / 3;
                    double x = avg - brightness;
                    //pixel = System.Drawing.Color.FromArgb(avg, avg, avg);
                    sum += x * x;

                }
            contrast = System.Math.Sqrt(sum / (L * K));
            label3.Text = "jasnosc = " + System.Math.Round(((double)brightness / 255) * 100, 0) + "%";
            label4.Text = "kontrast = " + System.Math.Round(((double)contrast / 127.5) * 100, 0) + "%";

            SetBitMap(ref m_ekran);
        }

        public void Zmien_obraz_jasnosc()
        {
            System.Drawing.Color pixel;
            double sum = 0;
            double brightness = 0;
            double contrast = 0;
            double x = hScrollBar2.Value;


            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);
                    int r = (int)System.Math.Max(System.Math.Min(x + pixel.R, 255), 0);
                    int g = (int)System.Math.Max(System.Math.Min(x + pixel.G, 255), 0);
                    int b = (int)System.Math.Max(System.Math.Min(x + pixel.B, 255), 0);
                    double avg = (double)(r + g + b) / 3;
                    pixel = System.Drawing.Color.FromArgb(r, g, b);
                    sum += avg;

                    //--------------------------------------//

                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            brightness = sum / (L * K);
            if (brightness == 255)
                contrast = 0;
            else
                contrast = System.Math.Sqrt(sum / (L * K));

            label3.Text = "jasnosc = " + System.Math.Round(((double)brightness / 255) * 100, 0) + "%";
            label4.Text = "kontrast = " + System.Math.Round(((double)contrast / 127.5) * 100, 0) + "%";
            

            SetBitMap(ref m_ekran);
        }
        public void Zmien_obraz_kontrast()
        {
            System.Drawing.Color pixel;
            double suma = 0;
            double jasnosc = 0;
            double kontrast = 0;
            int setVal = hScrollBar1.Value;


            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    double a;
                    if (setVal <= 0) a = 1.0 + (setVal / 256.0);
                    else a = 256.0 / System.Math.Pow(2, System.Math.Log(257 - setVal, 2));

                    int R = (int)System.Math.Min(System.Math.Max(a * (pixel.R - 127.5) + 127.5, 0), 255);
                    int G = (int)System.Math.Min(System.Math.Max(a * (pixel.G - 127.5) + 127.5, 0), 255);
                    int B = (int)System.Math.Min(System.Math.Max(a * (pixel.B - 127.5) + 127.5, 0), 255);
                    suma += (R + G + B) / 3;
                    pixel = System.Drawing.Color.FromArgb(R, G, B);

                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }
            jasnosc = suma / (L * K);

            suma = 0;
            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    double a;
                    if (setVal <= 0) a = 1.0 + (setVal / 256.0);
                    else a = 256.0 / System.Math.Pow(2, System.Math.Log(257 - setVal, 2));

                    int R = (int)System.Math.Min(System.Math.Max(a * (pixel.R - 127.5) + 127.5, 0), 255);
                    int G = (int)System.Math.Min(System.Math.Max(a * (pixel.G - 127.5) + 127.5, 0), 255);
                    int B = (int)System.Math.Min(System.Math.Max(a * (pixel.B - 127.5) + 127.5, 0), 255);
                    double r = (R + G + B) / 3 - jasnosc;
                    suma += r * r;
                }

            kontrast = System.Math.Sqrt(suma / (L * K));

            label3.Text = "Jasnoœæ = " + System.Math.Round(jasnosc / 255 * 100, 0) + "%";
            label4.Text = "Kontrast = " + System.Math.Round(kontrast / 127.5 * 100, 0) + "%";

            SetBitMap(ref m_ekran);
        }


        //------------------
        //------------------
        public void Efekt1()
        {
            //efekt: przesuwanie poziome obrazu w kierunku prawej strony ekranu 

            if (p >= K) p = 0;

            for (int j = 1; j <= L; j++)
            {
                for(int i = 1; i <= p; i++)
                    ReadTlo(N);
                for (int i = 1; i <= K - p; i++)
                    ReadPixel(i, j);
            }
        }

        //------------------
        //------------------
        public void Efekt2()
        {
            //efekt: zas³anianie pionowe obrazu w kierunku górnej krawêdzi ekranu

            if (p >= L) p = 0;

            for (int j = 1; j <= L - p; j++)
            {
                for (int i = 1; i <= K; i++)
                    ReadPixel(i, j);
            }

            for (int j = 1; j <= p; j++)
            {
                for (int i = 1; i <= K; i++)
                    ReadTlo(N);
            }
        }

        //------------------
        //------------------
        public void Efekt3()
        {
            //efekt: przewijanie obrazu wzd³u¿ przek¹tnej ekranu w kierunku górnego prawego wierzcho³ka

            if (p >= L) p = 0;

            for (int j = 1 + p; j <= L; j++)
            {
                for (int i = K - p; i < K; i++)
                    ReadTlo(N);
                for (int i = 1; i <= K - p; i++)
                    ReadPixel(i, j);
            }

            for (int j = 1; j <= p; j++)
            {
                for (int i = K - p; i < K; i++)
                    ReadPixel(i, j);
                for (int i = 1; i <= K - p; i++)
                    ReadTlo(N);
            }

        }

        //------------------
        //------------------
        public void Zmien_obraz()
        {
            System.Drawing.Color pixel;
            
            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                {
                    pixel = m_obraz_w_pamieci.GetPixel(i - 1, j - 1);

                    //--------------------------------------//
                    //miejsce na kod dokonuj¹cy zmianê obrazu
                    
                    pixel = System.Drawing.Color.FromArgb(pixel.R, pixel.G, pixel.B);

                    //--------------------------------------//
                    
                    m_ekran.SetPixel(i - 1, j - 1, pixel);
                }

            SetBitMap(ref m_ekran);
            hScrollBar1.Value = 0;
            hScrollBar2.Value = 0;

            SetBitMap(ref m_ekran);
        }
    }
}
