using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Xml;
using Aqwas.API.Models;
using Aqwas.API.ViewModels;

namespace Aqwas.API.Controllers
{
    [RoutePrefix("api/AQwas")]
    public class ValuesController : ApiController
    {
        AqwasEntities _aqwasEntities = new AqwasEntities();
        // GET api/values

        [Route("GetProviders")]
        public List<FeedsProviders> GetProviders()
        {
            var providers = new List<FeedsProviders>();
            var list = _aqwasEntities.Feeds.ToList();
            foreach (var item in list)
            {
                providers.Add(new FeedsProviders
                {
                    Id = item.Id,
                    Title = item.Name,
                    Category = _aqwasEntities.Categories.FirstOrDefault(c => c.Id == item.CategoryId)?.Name,
                    IsSubscribe = item.IsSubscribed ?? false
                });
            }

            return providers;
        }

        // GET api/values/5
        [Route("GetProviderDetails")]
        public List<Item> GetProviderDetails(int id)
        {
            var provider = _aqwasEntities.Feeds.FirstOrDefault(c => c.Id == id);
            List<Item> items = new List<Item>();
            XmlDocument xmlDoc = new XmlDocument();
            var uRLlink = provider?.Link;
            if (uRLlink != null) xmlDoc.Load(uRLlink);

            string xmlPathPattern = "//channel/item";
            XmlNodeList myNodeList = xmlDoc.SelectNodes(xmlPathPattern);
            DateTime dateTime;
            string date = string.Empty;
            foreach (XmlNode node in myNodeList)
            {
                XmlNode title = node.FirstChild;
                XmlNode link = title.NextSibling;
                XmlNode descrition = link?.NextSibling;
                XmlNode author = descrition?.NextSibling;
                if (DateTime.TryParse(author?.InnerText, out dateTime))
                {
                    date = author?.InnerText;
                }
                else
                {
                    XmlNode pupDate = author?.NextSibling;
                    if (DateTime.TryParse(pupDate?.InnerText, out dateTime))
                    {
                        date = pupDate?.InnerText;
                    }
                    else
                    {
                        date = string.Empty;
                    }
                }
                  
                items.Add(new Item()
                {
                    Title = title.InnerText,
                    Description = descrition?.InnerText,
                    Date = date
                });
            }

            return items;
        }

     
        [Route("Subscribe")]
        [HttpPost]
        public void Post(SubscribedItem model)
        {
            var user = Helper.ExecuteOpenWifiSettingsCommand();
            var userDb = _aqwasEntities.Users.FirstOrDefault(c => c.Username == user);
            var feed = _aqwasEntities.UserFeeds.FirstOrDefault(c => c.FeedId == model.Id);
            if (feed != null)
            {
                throw new Exception();
            }
            var userFeed = new UserFeed { FeedId = model.Id };
            if (userDb == null)
            {
                var userToInsert = new User()
                {
                    Username = user,
                    Email = user
                };
                _aqwasEntities.Users.AddOrUpdate(userToInsert);
                _aqwasEntities.SaveChanges();
                var insertedUser = _aqwasEntities.Users.FirstOrDefault(c => c.Username == user);
                if (insertedUser != null) userFeed.UserId = insertedUser.Id;
            }
            else
            {
                userFeed.UserId = userDb.Id;
            }

            _aqwasEntities.UpdateFeedsToBeSubscribed(userFeed.FeedId);
            _aqwasEntities.SubscribedUserFeeds(userFeed.UserId, userFeed.FeedId);
        }
        [Route("GetMyFeeds")]
        public List<MyFeedsViewModel> GetMyFeeds()
        {
            var user = Helper.ExecuteOpenWifiSettingsCommand();
            var userDb = _aqwasEntities.Users.FirstOrDefault(c => c.Username == user);
            var feedsList = new List<MyFeedsViewModel>();
            var list = _aqwasEntities.GetUserFeeds(userDb?.Id).ToList();
            foreach (var item in list)
            {
                feedsList.Add(new MyFeedsViewModel
                {
                    Id = item.Id,
                    Name = item.Name,
                    Date = Convert.ToString(item.FeedDate)
                });
            }

            return feedsList;
        }

    }
}
