using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        private readonly IWebHostEnvironment webHost;

        public ImageController(IWebHostEnvironment webHost)
        {
            this.webHost = webHost;
        }

        [HttpGet("{id}")]
        public IActionResult Get(string id)
        {
            var image = System.IO.File.OpenRead(Path.Combine(webHost.WebRootPath, "images", id));
            return File(image, "image/jpeg");
        }
    }
}
