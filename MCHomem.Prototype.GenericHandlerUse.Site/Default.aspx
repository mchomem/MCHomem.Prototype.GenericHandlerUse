﻿<%@ Page
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
                                            type="button">
                                            Clear</button>
                                        <button
                                            id="btnLoad"
                                            class="btn btn-sm btn-success"
                                            type="button">
                                            Load</button>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div id="container" class="card" style="display: none;">
                                        <div class="card-header">
                                            Records
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
    <script src="Scripts/controls/message-box.js"></script>

    <script type="text/javascript">

        // "Code behind" for javascript
        $(document).ready(function () {

            // Flat object of static javascript
            Default = {

                self: this

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
                        , data: 'op=getPeople'
                    })
                        .done(function (data, textStatus, jqXHR) {
                            self.$contentData.empty();

                            for (var i = 0; i < data.Entities.length; i++) {
                                self.$contentData.append('<b>Name:</b> ' + data.Entities[i].Name + '<br>');
                                self.$contentData.append('<b>Birth date:</b> ' + moment(data.Entities[i].BirthDate).format('DD[/]MM[/]YYYY HH[:]mm[:]ss') + '<br><br>');
                            }

                            MessageBox.show($('#messageBoxContainer'), 'Success!', data.Message, MessageBox.TypeMessage.SUCCESS);
                            self.$container.attr('style', 'display:block;');
                        })
                        .fail(function (jqXHR, textStatus, errorThrown) {
                            MessageBox.show($('#messageBoxContainer'), 'Error!', data.Message, MessageBox.TypeMessage.ERROR);
                        })
                        .always(function () {
                            self.$contentData.append('Done!');
                        });
                }

                , clear: function () {
                    self.$contentData.empty();
                    self.messageBoxContainer.empty();
                }
            }

            // Call to initial method.
            Default.init();
        });

    </script>
</body>
</html>
