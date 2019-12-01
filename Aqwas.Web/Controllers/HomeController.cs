using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using Aqwas.Web.Models;

namespace Aqwas.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {

            IEnumerable<FeedsProvider> feedsProviders = null;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:53234/api/AQwas/");
                //HTTP GET
                var responseTask = client.GetAsync("GetProviders");
                responseTask.Wait();

                var result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsAsync<IList<FeedsProvider>>();
                    readTask.Wait();

                    feedsProviders = readTask.Result;
                }
                else
                {
                    feedsProviders = Enumerable.Empty<FeedsProvider>();

                    ModelState.AddModelError(string.Empty, "Server error. Please contact administrator.");
                }
            }
            return View(feedsProviders);
        }

        public ActionResult Subscribe(int id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:53234/api/AQwas/");
                var model = new ItemToInsert()
                {
                    Id = id
                };
                //HTTP POST
                var postTask = client.PostAsJsonAsync<ItemToInsert>("Subscribe", model);
                postTask.Wait();

                var result = postTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    return RedirectToAction("Index");
                }
            }

            ModelState.AddModelError(string.Empty, "Server Error. Please contact administrator.");
            ViewBag.Error = "you subscribed to this provider before please choose another one";
            return View();
        }

        public ActionResult GetMyFeeds()
        {

            IEnumerable<MyFeedsViewModel> feeds = null;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:53234/api/AQwas/");
                //HTTP GET
                var responseTask = client.GetAsync("GetMyFeeds");
                responseTask.Wait();

                var result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsAsync<IList<MyFeedsViewModel>>();
                    readTask.Wait();

                    feeds = readTask.Result;
                }
                else //web api sent error response 
                {
                    //log response status here..

                    feeds = Enumerable.Empty<MyFeedsViewModel>();

                    ModelState.AddModelError(string.Empty, "Server error. Please contact administrator.");
                }
            }
            return View(feeds);
        }

        public ActionResult GetProvidersDetails(int id, string search)
        {
            ViewBag.Id = id;
            IEnumerable<Item> Items = null;

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:53234/api/AQwas/");

                var responseTask = client.GetAsync("GetProviderDetails?id=" + id);
                responseTask.Wait();

                var result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    var readTask = result.Content.ReadAsAsync<IList<Item>>();
                    readTask.Wait();

                    Items = readTask.Result;
                    if (!string.IsNullOrEmpty(search))
                    {
                        Items = Items.Where(c => c.Date == string.Empty || c.Date.Contains(search));
                    }
                }
                else //web api sent error response 
                {
                    //log response status here..

                    Items = Enumerable.Empty<Item>();

                    ModelState.AddModelError(string.Empty, "Server error. Please contact administrator.");
                }
            }
            return View(Items);
        }
    }
}