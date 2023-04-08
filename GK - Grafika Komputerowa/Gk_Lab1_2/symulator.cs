//-----------------------------------------------//
//Program do symulowania efekt�w graficznych     //
//uzyskiwanych na ekranie urz�dzenia rastrowego  //                 
//poprzez odpowiednie adresowanie pami�ci obrazu //
//                                               // 
//Do wykorzystania w ramach przedmiotu           //
//Grafika komputerowa                            //
//                                               // 
//Autor: Wojciech Sulej                          //
//Copyright: ITA WAT                             //
//Wersja: 1.10                                   //
//-----------------------------------------------//

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Graf_kom
{
    public partial class f_graf_kom : Form
    {
        readonly Bitmap m_obraz_w_pamieci;
        Bitmap m_ekran;

        int L;
        int K;

        int rasterX;
        int rasterY;
        
        int p;

        Color N;
        
        public f_graf_kom()
        {
            InitializeComponent();

            timer_automat.Interval = 1;

            N = Color.Black;
            
            Bitmap im = new Bitmap("photo.bmp");

            m_obraz_w_pamieci = (Bitmap)im.Clone();

            L = m_obraz_w_pamieci.Height;
            K = m_obraz_w_pamieci.Width;

            m_ekran = (Bitmap)im.Clone();
        }

        private void MoveRaster()
        {
            if (rasterX == m_ekran.Width - 1)
            {
                rasterX = 0;
                if (rasterY == m_ekran.Height - 1)
                {                    
                    rasterY = 0;

                }
                else
                    rasterY++;
            }
            else
                rasterX++;
        }

        public void ReadPixel(int i, int j)
        {
            m_ekran.SetPixel(rasterX, rasterY, m_obraz_w_pamieci.GetPixel(i - 1, j - 1));
            
            MoveRaster();
        }

        public void ReadTlo(Color kolor_tla)
        {
            m_ekran.SetPixel(rasterX, rasterY, kolor_tla);

            MoveRaster();
        }

        public void SetBitMap(ref Bitmap image)
        {
            picbx_ekran.Image = image;
            picbx_ekran.Refresh();
            
            lb_nr_klatki.Text = "klatka = " + p;
        }
        
        private void Work()
        {
            if (rb_przesuwanie.Checked) Efekt1();
            if (rb_zaslanianie.Checked) Efekt2();
            if (rb_przewijanie.Checked) Efekt3();
            progressBar2.Value = p;

            p++;
                                
            SetBitMap(ref m_ekran);
        }

        private void b_load_Click(object sender, EventArgs e)
        {
            p = 0;

            rasterX = 0;
            rasterY = 0;

            picbx_pamiec_obrazu.Image = m_obraz_w_pamieci;

            lb_roz_obrazu.Text = m_obraz_w_pamieci.Height.ToString() + " x " + m_obraz_w_pamieci.Width.ToString();

            for (int j = 1; j <= L; j++)
                for (int i = 1; i <= K; i++)
                    ReadTlo(N);

            picbx_ekran.Image = m_ekran;

            b_load.Enabled = false;
            b_reset.Enabled = true;

            b_start.Enabled = true;
            b_stop.Enabled = false;
            b_kolejna_klatka.Enabled = true;

            b_zmien_obraz.Enabled = true;
        }
        
        private void b_reset_Click(object sender, EventArgs e)
        {
            picbx_pamiec_obrazu.Image = null;
            lb_roz_obrazu.Text = "0 x 0";
            
            picbx_ekran.Image = null;
            lb_nr_klatki.Text = "klatka = 0";

            b_load.Enabled = true;
            b_reset.Enabled = false;

            b_start.Enabled = false;
            b_stop.Enabled = false;
            b_kolejna_klatka.Enabled = false;

            b_zmien_obraz.Enabled = false;

            progressBar2.Value = 0;
        }

        private void timer_automat_Tick(object sender, EventArgs e)
        {
            Work();
        }

        private void b_start_Click(object sender, EventArgs e)
        {
            timer_automat.Enabled = true;
            
            b_start.Enabled = false;
            b_stop.Enabled = true;
            b_kolejna_klatka.Enabled = false;

            b_reset.Enabled = false;
        }

        private void b_stop_Click(object sender, EventArgs e)
        {
            timer_automat.Enabled = false;

            b_start.Enabled = true;
            b_stop.Enabled = false;
            b_kolejna_klatka.Enabled = true;

            b_reset.Enabled = true;
           
        }

        private void b_kolejna_klatka_Click(object sender, EventArgs e)
        {
            Work();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (rb1.Checked) Zmien_obraz_hls();
            else if (rb2.Checked) Zmien_obraz_hsv();
            else if (rb3.Checked) Zmien_obraz_avg();
            else if (rb4.Checked) Zmien_obraz_kontrast();
            else if (rb5.Checked) Zmien_obraz_jasnosc();
            else Zmien_obraz();
        }

        private void f_graf_kom_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void progressBar2_Click(object sender, EventArgs e)
        {

        }

        private void lb_obraz_w_pamieci_opis_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
            Zmien_obraz_jasnosc();
        }

        private void hScrollBar2_Scroll(object sender, ScrollEventArgs e)
        {
            Zmien_obraz_kontrast();
        }
    }
}
