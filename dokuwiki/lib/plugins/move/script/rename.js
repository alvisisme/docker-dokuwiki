/**
 * Rename dialog for end users
 *
 * @author Andreas Gohr <gohr@cosmocode.de>
 */
if(JSINFO.move_renameokay)
    jQuery('.plugin_move_page')
        .show()
        .click(function(e) {
            e.preventDefault();

            var renameFN = function () {
                var self = this;
                var newid = $dialog.find('input[name=id]').val();
                if (!newid) return false;

                // remove buttons and show throbber
                $dialog.html(
                    '<img src="'+DOKU_BASE+'lib/images/throbber.gif" /> '+
                        LANG.plugins.move.inprogress
                );
                $dialog.dialog('option', 'buttons', []);

                // post the data
                jQuery.post(
                    DOKU_BASE + 'lib/exe/ajax.php',
                    {
                        call: 'plugin_move_rename',
                        id: JSINFO.id,
                        newid: newid
                    },
                    // redirect or display error
                    function (result) {
                        if(result.error){
                            $dialog.html(result.error.msg);
                        } else {
                            window.location.href = result.redirect_url;
                        }
                    }
                );

                return false;
            };

            // basic dialog template
            var $dialog = jQuery(
                '<div>' +
                    '<form>' +
                    '<label>' + LANG.plugins.move.newname + '<br>' +
                    '<input type="text" name="id" style="width:100%">' +
                    '</label>' +
                    '</form>' +
                    '</div>'
            );
            $dialog.find('input[name=id]').val(JSINFO.id);
            $dialog.find('form').submit(renameFN);

            // set up the dialog
            $dialog.dialog({
                title: LANG.plugins.move.rename+' '+JSINFO.id,
                width: 800,
                height: 180,
                dialogClass: 'plugin_move_dialog',
                modal: true,
                buttons: [
                    {
                        text: LANG.plugins.move.cancel,
                        click: function () {
                            $dialog.dialog("close");
                        }
                    },
                    {
                        text: LANG.plugins.move.rename,
                        click: renameFN
                    }
                ],
                // remove HTML from DOM again
                close: function () {
                    jQuery(this).remove();
                }
            })
        });
