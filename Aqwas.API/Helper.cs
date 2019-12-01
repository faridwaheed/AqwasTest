using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Web;
using System.Xml;

namespace Aqwas.API
{
    public static class Helper
    {
        static void parseXmlFile(string xmlData)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(xmlData);

            string xmlPathPattern = "//channel/item";
            XmlNodeList myNodeList = xmlDoc.SelectNodes(xmlPathPattern);
            foreach (XmlNode node in myNodeList)
            {
                XmlNode title = node.FirstChild;
                XmlNode link = title.NextSibling;
                XmlNode descrition = link.NextSibling;

            }
        }

       public static string ExecuteOpenWifiSettingsCommand()
        {
            var all = NetworkInterface.GetAllNetworkInterfaces();
            var sb = new StringBuilder();

            foreach (var inter in all)
            {
                var macBytes = inter.GetPhysicalAddress();

                if (macBytes == null) continue;

                foreach (var b in macBytes?.GetAddressBytes())
                {
                    sb.Append((b & 0xFF).ToString("X2") + ":");
                }

            }

            return Convert.ToString(sb).Substring(0, 17);
        }
    }
}