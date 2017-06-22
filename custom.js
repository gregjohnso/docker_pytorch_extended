// Configure CodeMirror
require([
    'nbextensions/vim_binding',   // depends your installation
], function() {
    // Map jj to <Esc>
    CodeMirror.Vim.map("fd", "<Esc>", "insert"); // Use fd to escape.
    // CodeMirror.Vim.map("fd", "<Esc>", "insert");
});
