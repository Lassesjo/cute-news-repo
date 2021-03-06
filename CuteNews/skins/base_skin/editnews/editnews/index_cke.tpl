<script src="core/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
function submitForm() { return true; }
function confirmDelete(url)
{
    var agree=confirm("Do you really want to permanently delete this article ?");
    if (agree) document.location = url;
}
</script>

{$error_messages}
{if $preview_hmtl}<div style="margin: 0 0 0 75px;">{$preview_hmtl}</div>{/if}

<form onSubmit= "return submitForm();" method="POST" name="addnews" action="{$PHP_SELF}">

    <input type="hidden" name="csrf_code" value="{$CSRF}" />
    <input type="hidden" name="id" value="{$id}">
    <input type="hidden" name="mod" value="editnews">
    <input type="hidden" name="action" value="editnews">
    <input type="hidden" name="subaction" value="doeditnews">
    <input type="hidden" name="source" value="{$source}">

    <table border=0 cellpadding=1 cellspacing=0 width="100%">
    {if $postpone_date}<tr><td>&nbsp;</td><td style="color: gray; padding: 8px 0">This is postpone news</td></tr>{/if}
    {if $saved}<tr><td>&nbsp;</td><td><h3 style="color: green;">The changes were successfully saved</h3></td></tr>{/if}
    <tr>
        <td width="75">&nbsp;</td>
        <td> Posted on {$newstime} by {$item_db1} </td>
    </tr>

    <tr>
        <td>Title</td>
        <td><input type=text name=title value="{$item_db2}" style="width: 675px;" tabindex=1></td>
    </tr>

    {$Hook_AdditionalFieldsTop}

    {if $xfields}
        <tr>
            <td align="right" valign="top">#&nbsp;</td>
            <td>
                <a href="#" onclick="DoDiv('add_flds_collapse'); return false;">More fields...</a>
                <div id="add_flds_collapse" style="display: none;">
                    <p><table class="panel">
                        {foreach from=xfields}
                            <tr>
                                <td align="right">{$xfields.1}&nbsp;</td>
                                <td colspan="2"><input tabindex=2 type=text size="42" value="{$xfields.3}" name="{$xfields.0}" >&nbsp;&nbsp;&nbsp;<span style="font-size:7pt">{$xfields.2}</span></td>
                            </tr>
                        {/foreach}
                        </table>
                    </p>
                </div>
            </td>
        </tr>
    {/if}

    {if $Using_Avat}
    <tr>
        <td>Avatar URL</td>
        <td> <input type=text name=editavatar value="{$item_db5}" size=42 tabindex=2>&nbsp;&nbsp;&nbsp;<span style="font-size:7pt">(optional)</span> </td>
    </tr>
    {/if}

    <tr>
        <td>Category</td>
        <td>
            {if $cat_lines} <table width="100%" border="0" cellspacing="0" cellpadding="0" class="panel"> {$lines_html} </table> {/if}
            {if !$cat_lines} <span style="color: gray;">{{No category}}</span> {/if}
        </td>
    </tr>

    <!-- Short story -->
    <tr>
        <td valign="top"> <br />Short Story</td>
        <td> <textarea style="resize: none; width: 680px; height: 240px;" rows="12" cols="74" id="short_story" name="short_story" tabindex=3>{$item_db3}</textarea> </td>
    </tr>

    <!-- Postponed options -->
    {if $postpone_date}
    <tr>
        <td align="right">Postponed</td>
        <td height="30">
            <select name="from_date_day">{$dated}</select>
            <select name="from_date_month">{$datem}</select>
            <select name="from_date_year">{$datey}</select>
            @ <input value='{$dateh}' style="text-align: center;" name="from_date_hour" size=3 type=text title='24 Hour format [hh]'  /> :
              <input value="{$datei}" style="text-align: center;" name="from_date_minutes" size=3 type=text title='Minutes [mm]' />

        </td>
    </tr>
    {/if}

    <!-- Full story -->
    <tr>
        <td valign="top"> <br />Full Story<br /><span style="font-size:7pt">(optional)</span> </td>
        <td> <textarea style="resize: none; width: 680px; height: 320px;" rows="12" cols="74" id="full_story" name="full_story" tabindex=4>{$item_db4}</textarea> </td>
    </tr>

    {$Hook_AdditionalFieldsBottom}

    <tr>
        <td>&nbsp;</td>
        <td>
            <br/>
            <table border=0 cellspacing=0 cellpadding=2 width=100%>
                <tr>
                    <td align="left">
                        <input type="submit" style='font-weight:bold' value="Save Changes" accesskey="s">
                        <button title="Preview the New Article" name="preview" value="preview" accesskey="p">Preview</button>
                    </td>
                    <td align="right">
                        {if $Unapproved}<input type=button value="Approve" onclick="javascript:document.location=('{$PHP_SELF}?mod=massactions&selected_news[]={$id}&action=mass_approve&source=unapproved&csrf_code={$CSRF}');"> &nbsp;{/if}
                        <input type="button" value="Delete" onClick="confirmDelete('{$PHP_SELF}?mod=editnews&action=editnews&subaction=doeditnews&source={$source}&ifdelete=yes&id={$id}')">
                    </td>
              </tr>
            </table>
        </td>
    </tr>

    </table>

</form>
<br/>

<!-- COMMENT FORM -->
<form method=post name=comments action="{$PHP_SELF}">
    <table border=0 cellpadding=0 cellspacing=0 width="100%" >

    {if $found_newsid}
    <tr>
        <td width="75">Comments</td>
        <td><b>Poster</b>, Comment preview</td>
        <td width="120"> <b>Date</b> </td>
        <td width="1">&nbsp;</td>
    </tr>
    {/if}
    {$Comments_HTML}

<script type="text/javascript">
    (function()
    {
        var settings =
        {
            skin: 'v2',
            width: 680,
            height: 350,
            customConfig: '',
            language: 'en',
            entities_latin: false,
            entities_greek: false,
enterMode : CKEDITOR.ENTER_BR,
shiftEnterMode: CKEDITOR.ENTER_P,
shiftEnterMode: CKEDITOR.ENTER_DIV,

            toolbar: [
                ['Source','Maximize','Scayt','PasteText','Undo','Redo','Find','Replace','-','SelectAll','RemoveFormat','NumberedList','BulletedList','Outdent','Indent'],
                ['Image','Table','HorizontalRule','Smiley'],
                ['Link','Unlink','Anchor'],
                ['Format','FontSize','TextColor','BGColor'],
                ['Bold','Italic','Underline','Strike','Blockquote'],
                ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],

            ],
            filebrowserBrowseUrl: '{$PHP_SELF}?&mod=images&action=quick&wysiwyg=true',
            filebrowserImageBrowseUrl: '{$PHP_SELF}?&mod=images&action=quick&wysiwyg=true'
        };

        {$CKEDITOR_Settings}
        CKEDITOR.replace( 'short_story', {$CKEDITOR_SetsName} );
        CKEDITOR.replace( 'full_story', {$CKEDITOR_SetsName} );
    })();

</script>
