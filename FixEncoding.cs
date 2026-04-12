using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Linq;

class Program
{
    static void Main()
    {
        var replacements = new Dictionary<string, string>()
        {
            {"MÍ S", "MÁS"},
            {"MÃ S", "MÁS"},
            {"MÍ\u00A0S", "MÁS"},
            {"MÃ\u00A0S", "MÁS"},
            {"SÍ\u00A0BADO", "SÁBADO"},
            {"SÍ BADO", "SÁBADO"}
        };

        var root = @"c:\Users\tonip\Desktop\LITTLE";
        var files = new List<string>();
        files.AddRange(Directory.GetFiles(root, "*.html", SearchOption.AllDirectories));
        files.AddRange(Directory.GetFiles(root, "*.js", SearchOption.AllDirectories));

        var keys = replacements.Keys.OrderByDescending(k => k.Length).ToList();

        foreach (var file in files)
        {
            string content = File.ReadAllText(file, new UTF8Encoding(false));
            bool changed = false;
            foreach (var key in keys)
            {
                if (content.Contains(key))
                {
                    content = content.Replace(key, replacements[key]);
                    changed = true;
                }
            }
            if (changed)
            {
                File.WriteAllText(file, content, new UTF8Encoding(false));
                Console.WriteLine("Fixed encoding in: " + file);
            }
        }
        Console.WriteLine("Encoding repair complete.");
    }
}
