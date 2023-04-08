using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Graf_kom
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new f_graf_kom());
        }
    }
}