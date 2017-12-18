using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace SendLogsService
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Started @ " + DateTime.Now.ToString());

            var bootArgs = ParseCommandLineArgs(args);

            if (!bootArgs.ContainsKey("path"))
            {
                Console.Error.WriteLine("Parameter path is not defined. Example: path=C:/SendLog/SendLogs.ps1");
                System.Environment.Exit(1);
            }

            double repeatInterval = 15;
            if (bootArgs.ContainsKey("interval"))
            {
                repeatInterval = ParseIntervalSeconds(bootArgs["interval"]);
            }

            var startTimeSpan = TimeSpan.Zero;
            var periodTimeSpan = TimeSpan.FromSeconds(repeatInterval);

            var timer = new System.Threading.Timer((e) =>
            {
                ActivateCommand(bootArgs["path"]);
            }, null, startTimeSpan, periodTimeSpan);

            Console.ReadLine();
            Console.WriteLine("Finished @ " + DateTime.Now.ToString());
        }

        private static Dictionary<string, string> ParseCommandLineArgs(string[] args)
        {
            var arguments = new Dictionary<string, string>();

            foreach (string argument in args)
            {
                string[] splitted = argument.Split('=');

                if (splitted.Length == 2)
                {
                    arguments[splitted[0]] = splitted[1];
                }
            }

            return arguments;
        }

        private static double ParseIntervalSeconds(string argSeconds)
        {
            // Execute every 15 seconds by default
            double seconds = 15;

            if (argSeconds != null)
            {
                seconds = Double.Parse(argSeconds);
            }

            return seconds;
        }

        private static void ActivateCommand(string path)
        {
            // Run Command (Execute powershell script)
            Console.WriteLine("Execute " + path + " @ " + DateTime.Now.ToString());

            ProcessStartInfo psi = new ProcessStartInfo("cmd.exe")
            {
                UseShellExecute = false,
                RedirectStandardInput = true,
                Arguments = path
            };
            Process proc = new Process() { StartInfo = psi };

            proc.Start();
            proc.WaitForExit();
            proc.Close();
        }
    }
}
