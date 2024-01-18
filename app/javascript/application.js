// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.complete-checkbox').forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
      const noteId = checkbox.dataset.noteId;
      const noteElement = document.getElementById(`note_${noteId}`);

      if (checkbox.checked) {
        noteElement.classList.add('completed');
        updateNoteStatus(noteId, true);
      } else {
        noteElement.classList.remove('completed');
        updateNoteStatus(noteId, false);
      }
    });
  });

  function updateNoteStatus(noteId, completed) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch(`/notes/${noteId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ note: { completed: completed } })
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error('Error:', error));
  }
});
