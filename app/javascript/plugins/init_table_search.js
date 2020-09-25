require('jquery');
require('datatables.net-bs4');

// For the searchable/sortable table
// "Object(...) is not a function" error while this runs
const initTableSearch = () => {
  $('#table-index').DataTable({
    "lengthChange": false,
    "dom": '<"text-left ml-3 searchbar-index"f>',
    "oLanguage": {
       "sSearch": "Filtrer"
    }
  });
  $('.dataTables_length').addClass('bs-select');
};

export { initTableSearch }
