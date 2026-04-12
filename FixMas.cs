using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

class Program
{
    static void Main()
    {
        string file = @"c:\Users\tonip\Desktop\LITTLE\js\translations.js";
        string content = File.ReadAllText(file, new UTF8Encoding(false));
        
        // Use regex to catch MÍ <any whitespace> S
        string replaced = Regex.Replace(content, @"MÍ\s*S", "MÁS");
        
        if (content != replaced)
        {
            File.WriteAllText(file, replaced, new UTF8Encoding(false));
            Console.WriteLine("Successfully replaced MÍ S -> MÁS");
        }
        else
        {
            Console.WriteLine("Target string not found.");
        }
    }
}
