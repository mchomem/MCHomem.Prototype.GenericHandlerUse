MessageBox = {
    // Attribute to behave like an "enum"
    TypeMessage: {
        ERROR: 'Error'
        , INFORMATION: 'Information'
        , SUCCESS: 'Success'
        , WARNING: 'Warning'
    }

    , show: function (messageBoxContainer, title, message, typeMessage) {

        messageBoxContainer.empty();
        self.$messageBox = $('<div></div>');
        self.$messageBox.attr('role', 'alert');

        var crossButtonClose = $('<span></span>');
        crossButtonClose.attr('ria-hidden', 'true');
        crossButtonClose.html('&times;');

        var buttonClose = $('<button></button>');
        buttonClose.attr('type', 'button');
        buttonClose.addClass('close');
        buttonClose.attr('data-dismiss', 'alert');
        buttonClose.attr('aria-label', 'Close');
        buttonClose.append(crossButtonClose);

        var titleContainer = $('<b></b>');
        titleContainer.text(title);

        var slice = $('<hr>');
        slice.addClass('mt-0 mb-2');

        var messageContainer = $('<p></p>');
        messageContainer.text(message);

        var defaultCss = 'alert mt-2 alert-';

        switch (typeMessage) {

            case MessageBox.TypeMessage.INFORMATION:
                self.$messageBox.addClass(`${defaultCss}primary`);
                break;

            case MessageBox.TypeMessage.WARNING:
                self.$messageBox.addClass(`${defaultCss}warning`);
                break;

            case MessageBox.TypeMessage.ERROR:
                self.$messageBox.addClass(`${defaultCss}danger`);
                break;

            case MessageBox.TypeMessage.SUCCESS:
                self.$messageBox.addClass(`${defaultCss}success`);
                break;

            default:
                self.$messageBox.addClass(`${defaultCss}Updaprimary`);
                break;
        }

        self.$messageBox.append(titleContainer);
        self.$messageBox.append(buttonClose);
        self.$messageBox.append(slice);
        self.$messageBox.append(messageContainer);
        messageBoxContainer.append(self.$messageBox);
    }
}