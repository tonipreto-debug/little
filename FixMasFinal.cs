using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

class Program
{
    static void Main()
    {
        string root = @"c:\Users\tonip\Desktop\LITTLE";
        foreach(var file in Directory.GetFiles(root, "*.js", SearchOption.AllDirectories))
        {
            string content = File.ReadAllText(file, Encoding.UTF8);
            string original = content;
            
            content = Regex.Replace(content, "\"btn_read_more\":\\s*\"LEER M.*?S", "\"btn_read_more\": \"LEER MÁS");
            content = Regex.Replace(content, "\"btn_read_more\":\\s*\"LLEGIR M.*?S", "\"btn_read_more\": \"LLEGIR MÁS");
            content = Regex.Replace(content, "\"btn_saber_mas\":\\s*\"SABER M.*?S", "\"btn_saber_mas\": \"SABER MÁS");
            
            if (content != original)
            {
                File.WriteAllText(file, content, new UTF8Encoding(false));
                Console.WriteLine("Fixed Regex in " + file);
            }
        }
    }
}
