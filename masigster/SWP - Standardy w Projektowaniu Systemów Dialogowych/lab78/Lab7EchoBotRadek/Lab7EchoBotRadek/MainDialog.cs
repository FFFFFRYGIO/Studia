using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Schema;
using System.Threading;
using System.Threading.Tasks;

namespace Lab7EchoBotRadek
{
    public class MainDialog : ComponentDialog
    {
        private readonly IStatePropertyAccessor<UserProfile> _userProfileAccessor;
        public MainDialog(UserState userState) : base(nameof(MainDialog))
        {
            _userProfileAccessor = userState.CreateProperty<UserProfile>("UserProfile");
            var waterfallSteps = new WaterfallStep[]
            {
                InitialStepAsync,
                FinalStepAsync,
            };
            AddDialog(new WaterfallDialog(nameof(WaterfallDialog), waterfallSteps));
            AddDialog(new TextPrompt(nameof(TextPrompt)));
        }
        private async Task<DialogTurnResult> InitialStepAsync(WaterfallStepContext
       stepContext, CancellationToken cancellationToken)
        {
            return await stepContext.PromptAsync(nameof(TextPrompt), new PromptOptions
            {
                Prompt = MessageFactory.Text("What is your name?")
            }, cancellationToken);
        }
        private async Task<DialogTurnResult> FinalStepAsync(WaterfallStepContext
       stepContext, CancellationToken cancellationToken)
        {
            var userProfile = await _userProfileAccessor.GetAsync(stepContext.Context, () => new
           UserProfile(), cancellationToken);
            userProfile.Name = (string)stepContext.Result;
            await stepContext.Context.SendActivityAsync(MessageFactory.Text($"Hello { userProfile.Name}!"), cancellationToken);
        return await stepContext.EndDialogAsync(cancellationToken: cancellationToken);
        }
    }
    public class UserProfile
    {
        public string Name { get; set; }
    }
}
