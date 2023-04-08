using System.Threading;
using System.Diagnostics;
namespace Graf_kom
{
    partial class f_graf_kom
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
            Process.GetCurrentProcess().Kill();
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.picbx_ekran = new System.Windows.Forms.PictureBox();
            this.picbx_pamiec_obrazu = new System.Windows.Forms.PictureBox();
            this.lb_obraz_w_pamieci_opis = new System.Windows.Forms.Label();
            this.lb_obraz_na_ekranie_opis = new System.Windows.Forms.Label();
            this.b_load = new System.Windows.Forms.Button();
            this.lb_roz_obrazu_opis = new System.Windows.Forms.Label();
            this.lb_roz_obrazu = new System.Windows.Forms.Label();
            this.b_kolejna_klatka = new System.Windows.Forms.Button();
            this.b_reset = new System.Windows.Forms.Button();
            this.lb_nr_klatki = new System.Windows.Forms.Label();
            this.b_start = new System.Windows.Forms.Button();
            this.b_stop = new System.Windows.Forms.Button();
            this.rb_przesuwanie = new System.Windows.Forms.RadioButton();
            this.rb_zaslanianie = new System.Windows.Forms.RadioButton();
            this.rb_przewijanie = new System.Windows.Forms.RadioButton();
            this.lb_efekty_opis = new System.Windows.Forms.Label();
            this.lb_wykonywanie_opis = new System.Windows.Forms.Label();
            this.lb_samoczynne_opis = new System.Windows.Forms.Label();
            this.lb_po_klatce_opis = new System.Windows.Forms.Label();
            this.timer_automat = new System.Windows.Forms.Timer(this.components);
            this.b_zmien_obraz = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.progressBar2 = new System.Windows.Forms.ProgressBar();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.hScrollBar1 = new System.Windows.Forms.HScrollBar();
            this.hScrollBar2 = new System.Windows.Forms.HScrollBar();
            this.rb3 = new System.Windows.Forms.RadioButton();
            this.rb2 = new System.Windows.Forms.RadioButton();
            this.rb1 = new System.Windows.Forms.RadioButton();
            this.rb4 = new System.Windows.Forms.RadioButton();
            this.rb5 = new System.Windows.Forms.RadioButton();
            ((System.ComponentModel.ISupportInitialize)(this.picbx_ekran)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.picbx_pamiec_obrazu)).BeginInit();
            this.SuspendLayout();
            // 
            // picbx_ekran
            // 
            this.picbx_ekran.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.picbx_ekran.Location = new System.Drawing.Point(216, 33);
            this.picbx_ekran.Name = "picbx_ekran";
            this.picbx_ekran.Size = new System.Drawing.Size(200, 200);
            this.picbx_ekran.TabIndex = 0;
            this.picbx_ekran.TabStop = false;
            // 
            // picbx_pamiec_obrazu
            // 
            this.picbx_pamiec_obrazu.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.picbx_pamiec_obrazu.Location = new System.Drawing.Point(10, 33);
            this.picbx_pamiec_obrazu.Name = "picbx_pamiec_obrazu";
            this.picbx_pamiec_obrazu.Size = new System.Drawing.Size(200, 200);
            this.picbx_pamiec_obrazu.TabIndex = 2;
            this.picbx_pamiec_obrazu.TabStop = false;
            // 
            // lb_obraz_w_pamieci_opis
            // 
            this.lb_obraz_w_pamieci_opis.AutoSize = true;
            this.lb_obraz_w_pamieci_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_obraz_w_pamieci_opis.Location = new System.Drawing.Point(7, 14);
            this.lb_obraz_w_pamieci_opis.Name = "lb_obraz_w_pamieci_opis";
            this.lb_obraz_w_pamieci_opis.Size = new System.Drawing.Size(106, 16);
            this.lb_obraz_w_pamieci_opis.TabIndex = 3;
            this.lb_obraz_w_pamieci_opis.Text = "Obraz w pamiêci";
            this.lb_obraz_w_pamieci_opis.Click += new System.EventHandler(this.lb_obraz_w_pamieci_opis_Click);
            // 
            // lb_obraz_na_ekranie_opis
            // 
            this.lb_obraz_na_ekranie_opis.AutoSize = true;
            this.lb_obraz_na_ekranie_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_obraz_na_ekranie_opis.Location = new System.Drawing.Point(213, 14);
            this.lb_obraz_na_ekranie_opis.Name = "lb_obraz_na_ekranie_opis";
            this.lb_obraz_na_ekranie_opis.Size = new System.Drawing.Size(109, 16);
            this.lb_obraz_na_ekranie_opis.TabIndex = 4;
            this.lb_obraz_na_ekranie_opis.Text = "Obraz na ekranie";
            // 
            // b_load
            // 
            this.b_load.Location = new System.Drawing.Point(423, 100);
            this.b_load.Name = "b_load";
            this.b_load.Size = new System.Drawing.Size(75, 23);
            this.b_load.TabIndex = 5;
            this.b_load.Text = "LOAD";
            this.b_load.UseVisualStyleBackColor = true;
            this.b_load.Click += new System.EventHandler(this.b_load_Click);
            // 
            // lb_roz_obrazu_opis
            // 
            this.lb_roz_obrazu_opis.AutoSize = true;
            this.lb_roz_obrazu_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_roz_obrazu_opis.Location = new System.Drawing.Point(111, 14);
            this.lb_roz_obrazu_opis.Name = "lb_roz_obrazu_opis";
            this.lb_roz_obrazu_opis.Size = new System.Drawing.Size(44, 16);
            this.lb_roz_obrazu_opis.TabIndex = 6;
            this.lb_roz_obrazu_opis.Text = "L x K =";
            // 
            // lb_roz_obrazu
            // 
            this.lb_roz_obrazu.AutoSize = true;
            this.lb_roz_obrazu.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_roz_obrazu.Location = new System.Drawing.Point(150, 14);
            this.lb_roz_obrazu.Name = "lb_roz_obrazu";
            this.lb_roz_obrazu.Size = new System.Drawing.Size(33, 16);
            this.lb_roz_obrazu.TabIndex = 7;
            this.lb_roz_obrazu.Text = "0 x 0";
            // 
            // b_kolejna_klatka
            // 
            this.b_kolejna_klatka.Enabled = false;
            this.b_kolejna_klatka.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.b_kolejna_klatka.Location = new System.Drawing.Point(537, 163);
            this.b_kolejna_klatka.Name = "b_kolejna_klatka";
            this.b_kolejna_klatka.Size = new System.Drawing.Size(108, 23);
            this.b_kolejna_klatka.TabIndex = 10;
            this.b_kolejna_klatka.Text = "Kolejna klatka";
            this.b_kolejna_klatka.UseVisualStyleBackColor = true;
            this.b_kolejna_klatka.Click += new System.EventHandler(this.b_kolejna_klatka_Click);
            // 
            // b_reset
            // 
            this.b_reset.Enabled = false;
            this.b_reset.Location = new System.Drawing.Point(501, 100);
            this.b_reset.Name = "b_reset";
            this.b_reset.Size = new System.Drawing.Size(75, 23);
            this.b_reset.TabIndex = 17;
            this.b_reset.Text = "RESET";
            this.b_reset.UseVisualStyleBackColor = true;
            this.b_reset.Click += new System.EventHandler(this.b_reset_Click);
            // 
            // lb_nr_klatki
            // 
            this.lb_nr_klatki.AutoSize = true;
            this.lb_nr_klatki.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_nr_klatki.Location = new System.Drawing.Point(442, 201);
            this.lb_nr_klatki.Name = "lb_nr_klatki";
            this.lb_nr_klatki.Size = new System.Drawing.Size(63, 16);
            this.lb_nr_klatki.TabIndex = 20;
            this.lb_nr_klatki.Text = "klatka = 0";
            // 
            // b_start
            // 
            this.b_start.Enabled = false;
            this.b_start.Location = new System.Drawing.Point(423, 163);
            this.b_start.Name = "b_start";
            this.b_start.Size = new System.Drawing.Size(51, 23);
            this.b_start.TabIndex = 21;
            this.b_start.Text = "START";
            this.b_start.UseVisualStyleBackColor = true;
            this.b_start.Click += new System.EventHandler(this.b_start_Click);
            // 
            // b_stop
            // 
            this.b_stop.Enabled = false;
            this.b_stop.Location = new System.Drawing.Point(480, 163);
            this.b_stop.Name = "b_stop";
            this.b_stop.Size = new System.Drawing.Size(51, 23);
            this.b_stop.TabIndex = 22;
            this.b_stop.Text = "STOP";
            this.b_stop.UseVisualStyleBackColor = true;
            this.b_stop.Click += new System.EventHandler(this.b_stop_Click);
            // 
            // rb_przesuwanie
            // 
            this.rb_przesuwanie.AutoSize = true;
            this.rb_przesuwanie.Checked = true;
            this.rb_przesuwanie.Location = new System.Drawing.Point(422, 33);
            this.rb_przesuwanie.Name = "rb_przesuwanie";
            this.rb_przesuwanie.Size = new System.Drawing.Size(154, 17);
            this.rb_przesuwanie.TabIndex = 23;
            this.rb_przesuwanie.TabStop = true;
            this.rb_przesuwanie.Text = "efekt przesuwania w prawo";
            this.rb_przesuwanie.UseVisualStyleBackColor = true;
            // 
            // rb_zaslanianie
            // 
            this.rb_zaslanianie.AutoSize = true;
            this.rb_zaslanianie.Location = new System.Drawing.Point(422, 55);
            this.rb_zaslanianie.Name = "rb_zaslanianie";
            this.rb_zaslanianie.Size = new System.Drawing.Size(141, 17);
            this.rb_zaslanianie.TabIndex = 24;
            this.rb_zaslanianie.Text = "efekt zas³aniania w górê";
            this.rb_zaslanianie.UseVisualStyleBackColor = true;
            // 
            // rb_przewijanie
            // 
            this.rb_przewijanie.AutoSize = true;
            this.rb_przewijanie.Location = new System.Drawing.Point(422, 77);
            this.rb_przewijanie.Name = "rb_przewijanie";
            this.rb_przewijanie.Size = new System.Drawing.Size(271, 17);
            this.rb_przewijanie.TabIndex = 25;
            this.rb_przewijanie.Text = "efekt przewijania wzd³u¿ przek¹tnej w górê w prawo";
            this.rb_przewijanie.UseVisualStyleBackColor = true;
            // 
            // lb_efekty_opis
            // 
            this.lb_efekty_opis.AutoSize = true;
            this.lb_efekty_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_efekty_opis.Location = new System.Drawing.Point(420, 12);
            this.lb_efekty_opis.Name = "lb_efekty_opis";
            this.lb_efekty_opis.Size = new System.Drawing.Size(44, 16);
            this.lb_efekty_opis.TabIndex = 26;
            this.lb_efekty_opis.Text = "Efekty";
            // 
            // lb_wykonywanie_opis
            // 
            this.lb_wykonywanie_opis.AutoSize = true;
            this.lb_wykonywanie_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_wykonywanie_opis.Location = new System.Drawing.Point(422, 126);
            this.lb_wykonywanie_opis.Name = "lb_wykonywanie_opis";
            this.lb_wykonywanie_opis.Size = new System.Drawing.Size(94, 16);
            this.lb_wykonywanie_opis.TabIndex = 27;
            this.lb_wykonywanie_opis.Text = "Wykonywanie:";
            // 
            // lb_samoczynne_opis
            // 
            this.lb_samoczynne_opis.AutoSize = true;
            this.lb_samoczynne_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_samoczynne_opis.Location = new System.Drawing.Point(422, 144);
            this.lb_samoczynne_opis.Name = "lb_samoczynne_opis";
            this.lb_samoczynne_opis.Size = new System.Drawing.Size(83, 16);
            this.lb_samoczynne_opis.TabIndex = 28;
            this.lb_samoczynne_opis.Text = "samoczynne";
            // 
            // lb_po_klatce_opis
            // 
            this.lb_po_klatce_opis.AutoSize = true;
            this.lb_po_klatce_opis.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lb_po_klatce_opis.Location = new System.Drawing.Point(539, 144);
            this.lb_po_klatce_opis.Name = "lb_po_klatce_opis";
            this.lb_po_klatce_opis.Size = new System.Drawing.Size(102, 16);
            this.lb_po_klatce_opis.TabIndex = 29;
            this.lb_po_klatce_opis.Text = "po jednej klatce";
            // 
            // timer_automat
            // 
            this.timer_automat.Tick += new System.EventHandler(this.timer_automat_Tick);
            // 
            // b_zmien_obraz
            // 
            this.b_zmien_obraz.Enabled = false;
            this.b_zmien_obraz.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.b_zmien_obraz.Location = new System.Drawing.Point(533, 192);
            this.b_zmien_obraz.Name = "b_zmien_obraz";
            this.b_zmien_obraz.Size = new System.Drawing.Size(108, 32);
            this.b_zmien_obraz.TabIndex = 30;
            this.b_zmien_obraz.Text = "Zmieñ obraz";
            this.b_zmien_obraz.UseVisualStyleBackColor = true;
            this.b_zmien_obraz.Click += new System.EventHandler(this.button1_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label1.Location = new System.Drawing.Point(7, 236);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(422, 16);
            this.label1.TabIndex = 31;
            this.label1.Text = "Wykona³: Rados³aw Relidzyñski grupa WCY20IJ1S1 data 3.11.2022 r.";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // progressBar2
            // 
            this.progressBar2.Location = new System.Drawing.Point(12, 256);
            this.progressBar2.MarqueeAnimationSpeed = 200;
            this.progressBar2.Maximum = 200;
            this.progressBar2.Name = "progressBar2";
            this.progressBar2.Size = new System.Drawing.Size(397, 21);
            this.progressBar2.TabIndex = 33;
            this.progressBar2.Click += new System.EventHandler(this.progressBar2_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(72, 311);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(46, 13);
            this.label4.TabIndex = 34;
            this.label4.Text = "Kontrast";
            this.label4.Click += new System.EventHandler(this.label4_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(262, 311);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(46, 13);
            this.label3.TabIndex = 35;
            this.label3.Text = "Jasnoœæ";
            // 
            // hScrollBar1
            // 
            this.hScrollBar1.LargeChange = 1;
            this.hScrollBar1.Location = new System.Drawing.Point(44, 333);
            this.hScrollBar1.Maximum = 255;
            this.hScrollBar1.Minimum = -255;
            this.hScrollBar1.Name = "hScrollBar1";
            this.hScrollBar1.Size = new System.Drawing.Size(186, 17);
            this.hScrollBar1.TabIndex = 36;
            // 
            // hScrollBar2
            // 
            this.hScrollBar2.LargeChange = 1;
            this.hScrollBar2.Location = new System.Drawing.Point(241, 333);
            this.hScrollBar2.Maximum = 255;
            this.hScrollBar2.Minimum = -255;
            this.hScrollBar2.Name = "hScrollBar2";
            this.hScrollBar2.Size = new System.Drawing.Size(174, 17);
            this.hScrollBar2.TabIndex = 37;
            // 
            // rb3
            // 
            this.rb3.AutoSize = true;
            this.rb3.Location = new System.Drawing.Point(435, 302);
            this.rb3.Name = "rb3";
            this.rb3.Size = new System.Drawing.Size(162, 17);
            this.rb3.TabIndex = 40;
            this.rb3.Text = "œrednia arytmetyczna R, G, B";
            this.rb3.UseVisualStyleBackColor = true;
            // 
            // rb2
            // 
            this.rb2.AutoSize = true;
            this.rb2.Location = new System.Drawing.Point(435, 280);
            this.rb2.Name = "rb2";
            this.rb2.Size = new System.Drawing.Size(98, 17);
            this.rb2.TabIndex = 39;
            this.rb2.Text = "RGB -> HSV(B)";
            this.rb2.UseVisualStyleBackColor = true;
            // 
            // rb1
            // 
            this.rb1.AutoSize = true;
            this.rb1.Location = new System.Drawing.Point(435, 258);
            this.rb1.Name = "rb1";
            this.rb1.Size = new System.Drawing.Size(84, 17);
            this.rb1.TabIndex = 38;
            this.rb1.Text = "RGB -> HLS";
            this.rb1.UseVisualStyleBackColor = true;
            // 
            // rb4
            // 
            this.rb4.AutoSize = true;
            this.rb4.Location = new System.Drawing.Point(435, 325);
            this.rb4.Name = "rb4";
            this.rb4.Size = new System.Drawing.Size(64, 17);
            this.rb4.TabIndex = 41;
            this.rb4.Text = "Kontrast";
            this.rb4.UseVisualStyleBackColor = true;
            // 
            // rb5
            // 
            this.rb5.AutoSize = true;
            this.rb5.Location = new System.Drawing.Point(505, 325);
            this.rb5.Name = "rb5";
            this.rb5.Size = new System.Drawing.Size(64, 17);
            this.rb5.TabIndex = 42;
            this.rb5.Text = "Jasnoœæ";
            this.rb5.UseVisualStyleBackColor = true;
            // 
            // f_graf_kom
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(698, 362);
            this.Controls.Add(this.rb5);
            this.Controls.Add(this.rb4);
            this.Controls.Add(this.rb3);
            this.Controls.Add(this.rb2);
            this.Controls.Add(this.rb1);
            this.Controls.Add(this.hScrollBar2);
            this.Controls.Add(this.hScrollBar1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.progressBar2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.b_zmien_obraz);
            this.Controls.Add(this.lb_po_klatce_opis);
            this.Controls.Add(this.lb_samoczynne_opis);
            this.Controls.Add(this.lb_wykonywanie_opis);
            this.Controls.Add(this.lb_efekty_opis);
            this.Controls.Add(this.rb_przewijanie);
            this.Controls.Add(this.rb_zaslanianie);
            this.Controls.Add(this.rb_przesuwanie);
            this.Controls.Add(this.b_stop);
            this.Controls.Add(this.b_start);
            this.Controls.Add(this.lb_nr_klatki);
            this.Controls.Add(this.b_reset);
            this.Controls.Add(this.b_kolejna_klatka);
            this.Controls.Add(this.lb_roz_obrazu);
            this.Controls.Add(this.lb_roz_obrazu_opis);
            this.Controls.Add(this.b_load);
            this.Controls.Add(this.lb_obraz_na_ekranie_opis);
            this.Controls.Add(this.lb_obraz_w_pamieci_opis);
            this.Controls.Add(this.picbx_pamiec_obrazu);
            this.Controls.Add(this.picbx_ekran);
            this.Location = new System.Drawing.Point(200, 100);
            this.MaximizeBox = false;
            this.Name = "f_graf_kom";
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "Symulator efektów";
            this.Load += new System.EventHandler(this.f_graf_kom_Load);
            ((System.ComponentModel.ISupportInitialize)(this.picbx_ekran)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.picbx_pamiec_obrazu)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox picbx_ekran;
        private System.Windows.Forms.PictureBox picbx_pamiec_obrazu;
        private System.Windows.Forms.Label lb_obraz_w_pamieci_opis;
        private System.Windows.Forms.Label lb_obraz_na_ekranie_opis;
        private System.Windows.Forms.Button b_load;
        private System.Windows.Forms.Label lb_roz_obrazu_opis;
        private System.Windows.Forms.Label lb_roz_obrazu;
        private System.Windows.Forms.Button b_kolejna_klatka;
        private System.Windows.Forms.Button b_reset;
        private System.Windows.Forms.Label lb_nr_klatki;
        private System.Windows.Forms.Button b_start;
        private System.Windows.Forms.Button b_stop;
        private System.Windows.Forms.RadioButton rb_przesuwanie;
        private System.Windows.Forms.RadioButton rb_zaslanianie;
        private System.Windows.Forms.RadioButton rb_przewijanie;
        private System.Windows.Forms.Label lb_efekty_opis;
        private System.Windows.Forms.Label lb_wykonywanie_opis;
        private System.Windows.Forms.Label lb_samoczynne_opis;
        private System.Windows.Forms.Label lb_po_klatce_opis;
        private System.Windows.Forms.Timer timer_automat;
        private System.Windows.Forms.Button b_zmien_obraz;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ProgressBar progressBar2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.HScrollBar hScrollBar1;
        private System.Windows.Forms.HScrollBar hScrollBar2;
        private System.Windows.Forms.RadioButton rb3;
        private System.Windows.Forms.RadioButton rb2;
        private System.Windows.Forms.RadioButton rb1;
        private System.Windows.Forms.RadioButton rb4;
        private System.Windows.Forms.RadioButton rb5;
    }
}

