using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using KR.Shikaku.Models;
using System.IO;
using System.Text.RegularExpressions;

namespace KR.Shikaku.Controllers
{
    public class HomeController : Controller
    {
        private readonly List<ShikakuFileModel> files = new List<ShikakuFileModel>();
        public HomeController()
        {
            files.Add(new ShikakuFileModel { Id = 1, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\5×5_0.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\5×5_0.txt" });
            files.Add(new ShikakuFileModel { Id = 2, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\5×5_1.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\5×5_1.txt" });
            files.Add(new ShikakuFileModel { Id = 3, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\5×5_2.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\5×5_2.txt" });
            files.Add(new ShikakuFileModel { Id = 4, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\10×10_0.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\10×10_0.txt" });
            files.Add(new ShikakuFileModel { Id = 5, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\15×15_0.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\15×15_0.txt" });
            files.Add(new ShikakuFileModel { Id = 6, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\25×25_0.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\25×25_0.txt" });
            files.Add(new ShikakuFileModel { Id = 7, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\25×25_1.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\25×25_1.txt" });
            files.Add(new ShikakuFileModel { Id = 8, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\daily.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\daily.txt" });
            files.Add(new ShikakuFileModel { Id = 9, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\weekly.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\weekly.txt" });
            files.Add(new ShikakuFileModel { Id = 10, CluesFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\Clues\monthly.txt", SolutionFilePath = @"C:\KR\KR.Shikaku\KR.Shikaku\MinizincModels\monthly.txt" });
        }
        public IActionResult Index(int id)
        {
            var index = id == 0 ? 1 : id;
            var fileModel = files.FirstOrDefault(x => x.Id == index);
            var clues = ReadClueFile(fileModel.CluesFilePath);
            var solution = ReadClueFile(fileModel.SolutionFilePath);
            var data = new ShikakuModel { Clues = clues, Solution = solution};
            return View(data);
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        private List<List<int>> ReadClueFile(string path)
        {
            //var cluesFiles = Directory.EnumerateFiles(@"C:\KR\KR.Shikaku\KR.Shikaku\Clues", "*.txt");
            //foreach (string currentFile in cluesFiles)
            //{
                string[] lines = System.IO.File.ReadAllLines(path);
                string pattern = @"(\d+)+";
                var matrixClues = new List<List<int>>();
                foreach (string line in lines)
                {
                    Regex rgx = new Regex(pattern);
                    var matches = rgx.Matches(line);
                    if(matches.Count > 0)
                        matrixClues.Add(matches.Select(x => int.Parse(x.Value)).ToList());
                }
            return matrixClues;
            //}
        }
    }
}
