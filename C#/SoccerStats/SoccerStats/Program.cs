using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;
using System.Net;

namespace SoccerStats
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.BufferHeight = 9999;

            string currentDirectory = Directory.GetCurrentDirectory();
            DirectoryInfo directory = new DirectoryInfo(currentDirectory);

            /*
            var files = directory.GetFiles("*.txt");
            Console.WriteLine("Files in this directory:");
            foreach(var _file in files)
            {
                Console.WriteLine(_file.Name);
            }

            Console.WriteLine("Hello World!");

            var fileName = Path.Combine(directory.FullName, "data.txt");
            var file = new FileInfo(fileName);

            if (file.Exists)
            {
                using (var reader = new StreamReader(file.FullName))
                {
                    Console.SetIn(reader);
                    Console.WriteLine("from " + file.FullName + ": " + Console.ReadLine());
                }
            }
            */

            /*
            var fileName = Path.Combine(directory.FullName, "SoccerGameResults.csv");
            var fileContents = ReadFile(fileName);
            string[] fileLines = fileContents.Split(new char[] {'\n'}, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in fileLines)
            {
                Console.WriteLine(line);
            }

            ReadSoccerResults(fileName);

            fileName = Path.Combine(directory.FullName, "players.json");
            var players = DeserializePlayers(fileName);

            int i = 0;
            foreach(var player in players)
            {
                Console.WriteLine(i++ + " " +player.FirstName + " " + player.LastName);
            }

            fileName = Path.Combine(directory.FullName, "topTenPlayers.txt");
            SerializePlayersToFile(GetTopTenPlayers(players), fileName);
            */

            /*
            string googleHomePage = GetGoogleHomePage();
            Console.WriteLine(googleHomePage);
            */

            /*
            string playerNews = GetNewsForPlayer("David Lin");
            Console.WriteLine(playerNews);
            */

            /*
            string stringResponse = GetStringResponse("https://teamtreehouse.com");
            Console.WriteLine(stringResponse);
            */

            var fileName = Path.Combine(directory.FullName, "players.json");
            var players = DeserializePlayers(fileName);

            foreach (var player in GetTopTenPlayers(players))
            {
                var searchTerm = string.Format("{0} {1}", player.FirstName, player.LastName);
                List<NewsResult> newsResults = GetNewsForPlayer(searchTerm);
                SentimentResponse sentimentResponse = GetSentimentResponse(newsResults);

                foreach(var sentiment in sentimentResponse.Sentiments)
                {
                    foreach(var newsResult in newsResults)
                    {
                        if (newsResult.Headline == sentiment.Id)
                        {
                            double score;
                            if (double.TryParse(sentiment.Score, out score))
                            {
                                newsResult.SentimentScore = score;
                            }
                            break;
                        }
                    }
                }

                foreach(var result in newsResults)
                {
                    Console.WriteLine(string.Format("Sentiment Score: {0:P}, Date: {1:f}, Headline: {2}, Summary: {3} \r\n", result.SentimentScore, result.DatePublished, result.Headline, result.Summary));
                    Console.ReadKey();
                }
            }

            Console.ReadKey();
        }

        public static string ReadFile(string fileName)
        {
            using (var reader = new StreamReader(fileName))
            {
                return reader.ReadToEnd();
            }
        }

        public static List<GameResult> ReadSoccerResults(string fileName)
        {
            var soccerResults = new List<GameResult>();

            using (var reader = new StreamReader(fileName))
            {
                string line = "";
                reader.ReadLine();
                while((line = reader.ReadLine()) != null)
                {
                    var gameResult = new GameResult();
                    string[] values = line.Split(',');

                    DateTime gameDate;
                    if (DateTime.TryParse(values[0], out gameDate))
                    {
                        gameResult.GameDate = gameDate;
                    }

                    gameResult.TeamName = values[1];

                    HomeOrAway homeOrAway;
                    if (Enum.TryParse(values[2], out homeOrAway))
                    {
                        gameResult.HomeOrAway = homeOrAway;
                    }

                    int parseInt;
                    if (int.TryParse(values[3], out parseInt))
                    {
                        gameResult.Goals = parseInt;
                    }

                    if (int.TryParse(values[4], out parseInt))
                    {
                        gameResult.GoalAttempts = parseInt;
                    }

                    if (int.TryParse(values[5], out parseInt))
                    {
                        gameResult.ShotsOnGoal = parseInt;
                    }

                    if (int.TryParse(values[6], out parseInt))
                    {
                        gameResult.ShotsOffGoal = parseInt;
                    }

                    double possessionPercent;
                    if (double.TryParse(values[7], out possessionPercent))
                    {
                        gameResult.PossessionPercent = possessionPercent;
                    }
                    
                    soccerResults.Add(gameResult);
                }
            }

            return soccerResults;
        }

        public static List<Player> DeserializePlayers(string fileName)
        {
            var players = new List<Player>();
            var serializer = new JsonSerializer();

            using (var reader = new StreamReader(fileName))
            using (var jsonReader = new JsonTextReader(reader))
            {
                players = serializer.Deserialize<List<Player>>(jsonReader);

            }

            return players;
        }

        public static void SerializePlayersToFile(List<Player> players, string fileName)
        {
            var serializer = new JsonSerializer();

            using (var writer = new StreamWriter(fileName))
            using (var jsonWriter = new JsonTextWriter(writer))
            {
                serializer.Serialize(jsonWriter, players);
            }
        }

        public static List<Player> GetTopTenPlayers(List<Player> players)
        {
            var topTenPlayers = new List<Player>();
            players.Sort(new PlayerComparer());
            int counter = 0;
            foreach(var player in players)
            {
                topTenPlayers.Add(player);
                if (++counter == 10)
                {
                    break;
                }
            }
            return topTenPlayers;
        }

        public static string GetGoogleHomePage()
        {
            var webClient = new WebClient();
            byte[] googleHome = webClient.DownloadData("https://www.google.com");
            using (var stream = new MemoryStream(googleHome))
            using (var reader = new StreamReader(stream))
            {
                return reader.ReadToEnd();
            }
        }

        public static List<NewsResult> GetNewsForPlayer(string playerName)
        {
            var results = new List<NewsResult>();

            var webClient = new WebClient();
            webClient.Headers.Add("Ocp-Apim-Subscription-Key", "c1839e9d18594afaadd7adeb03f88eaa");
            string url = string.Format("https://api.cognitive.microsoft.com/bing/v5.0/news/search?q={0}&mkt=en-us", playerName);
            byte[] searchResults = webClient.DownloadData(url);

            var serializer = new JsonSerializer();

            using (var stream = new MemoryStream(searchResults))
            using (var reader = new StreamReader(stream))
            using (var jsonReader = new JsonTextReader(reader))
            {
                results = serializer.Deserialize<NewsSearch>(jsonReader).NewsResult;
            }

            return results;
        }

        public static string GetStringResponse(string url)
        {
            string response = "";
            using (var webClient = new WebClient())
            {
                response = webClient.DownloadString(url);
            }
            return response;
        }

        public static SentimentResponse GetSentimentResponse(List<NewsResult> newsResults)
        {
            var sentimentResponse = new SentimentResponse();
            var sentimentRequest = new SentimentRequest();

            sentimentRequest.Documents = new List<Document>();

            foreach(var result in newsResults)
            {
                sentimentRequest.Documents.Add(new Document { Id = result.Headline, Text = result.Summary });
            }

            var webClient = new WebClient();
            webClient.Headers.Add("Ocp-Apim-Subscription-Key", "b677eb323e74442f9691a8cc37a74380");
            webClient.Headers.Add(HttpRequestHeader.Accept, "application/json");
            webClient.Headers.Add(HttpRequestHeader.ContentType, "application/json");

            string requestJson = JsonConvert.SerializeObject(sentimentRequest);
            byte[] requestBytes = Encoding.UTF8.GetBytes(requestJson);

            string url = "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment";
            byte[] response = webClient.UploadData(url, requestBytes);

            string sentiments = Encoding.UTF8.GetString(response);
            sentimentResponse = JsonConvert.DeserializeObject<SentimentResponse>(sentiments);

            return sentimentResponse;
        }
    }
}
