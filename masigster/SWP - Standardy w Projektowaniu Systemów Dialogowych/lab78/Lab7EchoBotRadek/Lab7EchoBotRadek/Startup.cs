using Lab7EchoBotRadek.Bots;
using Lab7EchoBotRadek;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Integration.AspNet.Core;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Bot.Builder.BotFramework;
using Microsoft.Bot.Connector.Authentication;
using Microsoft.AspNetCore.Mvc;

namespace Lab7EchoBotRadek
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        public IConfiguration Configuration { get; }
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddHttpClient().AddControllers().AddNewtonsoftJson(options =>
            {
                options.SerializerSettings.MaxDepth = HttpHelper.BotMessageSerializerSettings.MaxDepth;
            });

            // Create the Bot Framework Authentication to be used with the Bot Adapter.
            services.AddSingleton<BotFrameworkAuthentication, ConfigurationBotFrameworkAuthentication>();

            // Create the Bot Adapter with error handling enabled.
            services.AddSingleton<IBotFrameworkHttpAdapter, AdapterWithErrorHandler>();

            // Register MemoryStorage as the implementation of IStorage
            services.AddSingleton<IStorage, MemoryStorage>();

            // Register ConversationState and UserState
            services.AddSingleton<ConversationState>();
            services.AddSingleton<UserState>();

            // Register MainDialog
            services.AddSingleton<MainDialog>();

            // Create the bot as a transient. In this case the ASP Controller is expecting an IBot.
            services.AddTransient<IBot, BotWithDialogs>(sp =>
            {
                var userState = sp.GetRequiredService<UserState>();
                var mainDialog = sp.GetRequiredService<MainDialog>();
                return new BotWithDialogs(mainDialog, userState);
            });
        }
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseDefaultFiles()
                .UseStaticFiles()
                .UseWebSockets()
                .UseRouting()
                .UseAuthorization()
                .UseEndpoints(endpoints =>
                {
                    endpoints.MapControllers();
                });
            // app.UseHttpsRedirection();
        }
    }
}
