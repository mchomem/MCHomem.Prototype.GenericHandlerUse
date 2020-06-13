<%@ Page
    Language="C#"
    AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="MCHomem.Prototype.GenericHandlerUse.Site.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <title>Prototype Generic Handler</title>
</head>
<body>

    <%--Structure of the html form with bootstrap--%>
    <form id="frmMain" runat="server">
        <div class="container-fluid">
            <div class="row mt-3 mb-3">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white py-2">
                            <h4 class="">Simple form</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <button
                                            id="btnClear"
                                            class="btn btn-sm btn-outline-success"
                                            type="button">Clear</button>
                                        <button
                                            id="btnLoad"
                                            class="btn btn-sm btn-success"
                                            type="button">Load</button>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div id="container" class="card" style="display: none;">
                                        <div class="card-header">
                                            Registers
                                        </div>
                                        <div id="contentData" class="card-body"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer py-1">
                            <div id="messageBoxContainer"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="Scripts/jquery-3.4.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/popper.js"></script>
    <script src="Scripts/moment.js"></script>

    <script type="text/javascript">

        //"Code behind" for javascript
        $(document).ready(function () {

            // Flat object of static javascript
            Default = {

                // Attribute to behave like an "enum"
                TypeMessage: {
                    ERROR: 'Error'
                    , INFORMATION: 'Information'
                    , SUCCESS: 'Success'
                    , WARNING: 'Warning'
                }

                // Attribute
                , self: this

                // Initial method
                , init: function () {
                    // With calls to other methods.
                    this.getControls();
                    this.attachEvent();
                }

                // Method for obtaining page controls
                // The advantage here is that the form controls are "registered" only once
                // so as not to be called all the time with the jquery selector, ex: $('myControle')
                , getControls: function () {
                    self.$container = $('#container');
                    self.$contentData = $('#contentData');
                    self.$btnClear = $('#btnClear');
                    self.$btnLoad = $('#btnLoad');
                }

                // Method for attaching events
                , attachEvent: function () {

                    self.$btnClear.on('click', function () {
                        Default.clear();
                    });

                    self.$btnLoad.on('click', function () {
                        Default.load();
                    });
                }

                // Method to load data from an endpoint, webapi, webservice, etc,
                // in this case of an "endpoint" like the generic handler.
                , load: function () {
                    $.get({
                        url: 'ashx/AnyService.ashx'
                        , data: 'op=getPeoples'
                    })
                        .done(function (data, textStatus, jqXHR) {
                            self.$contentData.empty();

                            for (var i = 0; i < data.Peoples.length; i++) {
                                self.$contentData.append('<b>Name:</b> ' + data.Peoples[i].Name + '<br>');
                                self.$contentData.append('<b>Birth date:</b> ' + moment(data.Peoples[i].BirthDate).format('DD[/]MM[/]YYYY HH[:]mm[:]ss') + '<br><br>');
                            }

                            Default.showMessageBox('Success!', data.Message, Default.TypeMessage.SUCCESS);
                            self.$container.attr('style', 'display:block;');
                        })
                        .fail(function (jqXHR, textStatus, errorThrown) {
                            Default.showMessageBox('Error!', data.Message, Default.TypeMessage.ERROR);
                        })
                        .always(function () {
                            self.$contentData.append('Done!');
                        });
                }

                , clear: function () {
                    self.$contentData.empty();
                    self.messageBoxContainer.empty();
                }

                // Method for handling a component of the form, in this case a message box.
                // The idea is to create a component of this part and reference it on a main page
                // As long as the forms have the container
                , showMessageBox: function (title, message, typeMessage) {

                    self.messageBoxContainer = $('#messageBoxContainer');
                    self.messageBoxContainer.empty();

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

                    switch (typeMessage) {
                        case Default.TypeMessage.INFORMATION:
                            self.$messageBox.addClass('alert alert-primary');
                            break;

                        case Default.TypeMessage.WARNING:
                            self.$messageBox.addClass('alert alert-warning');
                            break;

                        case Default.TypeMessage.ERROR:
                            self.$messageBox.addClass('alert alert-danger');
                            break;

                        case Default.TypeMessage.SUCCESS:
                            self.$messageBox.addClass('alert alert-success');
                            break;

                        default:
                            self.$messageBox.addClass('alert alert-primary');
                            break;
                    }

                    self.$messageBox.append(titleContainer);
                    self.$messageBox.append(buttonClose);
                    self.$messageBox.append(slice);
                    self.$messageBox.append(messageContainer);
                    messageBoxContainer.append(self.$messageBox);
                }
            }

            // Call to initial method.
            Default.init();
        });

    </script>
</body>
</html>
