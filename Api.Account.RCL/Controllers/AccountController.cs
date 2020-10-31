using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Api.Account.RCL
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {

        [HttpGet("test")]
        public JsonResult Test()
        {
            return new JsonResult(new { Working = true });
        }

    }
}
