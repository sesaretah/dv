CKEDITOR.editorConfig = function (config) {
config.language = "fa";
config.ContentLangDirection = 'rtl' ;
config.height = 350;
config.toolbarGroups = [
  { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
{ name: 'forms', groups: [ 'forms' ] },
{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
'/',
{ name: 'links', groups: [ 'links' ] },
{ name: 'insert', groups: [ 'insert' ] },
{ name: 'styles', groups: [ 'styles' ] },
{ name: 'colors', groups: [ 'colors' ] },
{ name: 'tools', groups: [ 'tools' ] },
{ name: 'others', groups: [ 'others' ] },
{ name: 'about', groups: [ 'about' ] }
];

config.removeButtons = 'Source,Templates,NewPage,Preview,Print,Cut,Copy,Paste,PasteText,PasteFromWord,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Strike,CopyFormatting,RemoveFormat,Outdent,Indent,Blockquote,CreateDiv,Language,Flash,HorizontalRule,SpecialChar,PageBreak,Iframe,Font,Maximize,ShowBlocks,About,Smiley,Anchor';

}
;
