using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Schema;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Lab7EchoBotRadek
{
    public class BotWithDialogs : ActivityHandler
    {
        private readonly Dialog _dialog;
        private readonly UserState _userState;
        public BotWithDialogs(Dialog dialog, UserState userState)
        {
            _dialog = dialog;
            _userState = userState;
        }
        protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity>
       turnContext, CancellationToken cancellationToken)
        {
            await _dialog.RunAsync(turnContext,
           _userState.CreateProperty<DialogState>("DialogState"), cancellationToken);
        }
        public override async Task OnTurnAsync(ITurnContext turnContext, CancellationToken
       cancellationToken = default)
        {
            await base.OnTurnAsync(turnContext, cancellationToken);
            await _userState.SaveChangesAsync(turnContext, false, cancellationToken);
        }
    }
}
