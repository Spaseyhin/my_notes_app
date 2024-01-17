document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.complete-checkbox').forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
      const noteId = checkbox.dataset.noteId;
      const noteElement = document.getElementById(`note_${noteId}`);

      if (checkbox.checked) {
        updateNoteStatus(noteId, true, noteElement);
      } else {
        updateNoteStatus(noteId, false, noteElement);
      }
    });
  });

  // Применение стилей к заметкам при первоначальной загрузке
  document.querySelectorAll('.complete-checkbox').forEach(function(checkbox) {
    const noteId = checkbox.dataset.noteId;
    const noteElement = document.getElementById(`note_${noteId}`);

    if (checkbox.checked) {
      noteElement.classList.add('completed');
    }
  });

  function updateNoteStatus(noteId, completed, noteElement) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch(`/notes/${noteId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ note: { completed: completed } })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      console.log(data);
      if (completed) {
        noteElement.classList.add('completed');
      } else {
        noteElement.classList.remove('completed');
      }

      // Обновление страницы после успешного обновления
      location.reload();
    })
    .catch(error => console.error('Error:', error));
  }
});
