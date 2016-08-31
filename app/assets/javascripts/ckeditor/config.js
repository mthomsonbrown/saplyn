/* global CKEDITOR */

CKEDITOR.editorConfig = function (config) {
  // Removing lots of stuff from the toolbar.  A full list can be found at: 
  // http://ckeditor.com/forums/CKEditor/Complete-list-of-toolbar-items
  var buttonsToRemove = 'Underline,JustifyCenter,Save,NewPage,DocProps,Preview'
  buttonsToRemove += ',Print,Templates,document,Cut,Copy,Paste,PasteText'
  buttonsToRemove += ',PasteFromWord,Undo,Redo,Replace,SelectAll,About,Unlink'
  buttonsToRemove += ',Anchor,ShowBlocks'
  
  
  // config.removeButtons = buttonsToRemove;

  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  
    "Superscript"],
  ];
  config.toolbar = "simple";
}