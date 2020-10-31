using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;
using System.Threading.Tasks;
using Xunit;

[assembly: WebApplicationFactoryContentRoot("Api.Web, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "", "appsettings.json", "1")]
namespace Api.Web.Tests
{
    public class UnitTest : IClassFixture<WebApplicationFactory<Startup>>
    {
        private readonly WebApplicationFactory<Startup> _factory;

        public UnitTest(WebApplicationFactory<Startup> factory)
        {
            _factory = factory;
        }

        [Fact]
        public async Task Test()
        {
            var client = _factory.CreateClient();
            var response = await client.GetAsync("/api/Account/test");

            response.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
    }
}
