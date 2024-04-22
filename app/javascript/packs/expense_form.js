$(document).on('turbolinks:load', function() {
  // Function to recalculate amounts when item amounts change
  function recalculateAmounts() {
    let subtotalAmount = 0;
    let subtotalsPerUser = {};

    $('.item-row').each(function() {
      const itemAmount = parseFloat($(this).find('.item-amount').val()) || 0;
      subtotalAmount += itemAmount;

      // Distribute the item amount to participants if 'Equal' is checked
      const equalShare = $(this).find('.equal-share-checkbox').is(':checked');
      const participantInputs = $(this).find('.participant-amount');

      if (equalShare) {
        const share = itemAmount / participantInputs.length;
        participantInputs.val(share.toFixed(2));
      }

      // Add to each user's subtotal
      participantInputs.each(function(index) {
        const userId = $(this).data('user-id');
        const userAmount = parseFloat($(this).val()) || 0;
        subtotalsPerUser[userId] = (subtotalsPerUser[userId] || 0) + userAmount;
      });
    });

    // Update subtotal amounts
    $('#subtotal-value').text(subtotalAmount.toFixed(2));

    // Calculate and update tax and tip per user
    const tax = parseFloat($('#tax_amount').val()) || 0;
    const tip = parseFloat($('#tip_amount').val()) || 0;
    $('#hidden_tax_amount').val(tax);
    $('#hidden_tip_amount').val(tip);
    const numberOfUsers = Object.keys(subtotalsPerUser).length;
    const taxPerUser = tax / numberOfUsers;
    const tipPerUser = tip / numberOfUsers;

    for (const userId in subtotalsPerUser) {
      $(`#tax-user-${userId}`).val(taxPerUser.toFixed(2));
      $(`#tip-user-${userId}`).val(tipPerUser.toFixed(2));
      $(`#subtotal-user-${userId}`).text(subtotalsPerUser[userId].toFixed(2));
    }

    // Calculate grand totals
    const grandTotalAmount = subtotalAmount + tax + tip;
    $('#total_amount').val(grandTotalAmount);
    $('#grand-total-value').text(grandTotalAmount.toFixed(2));
    for (const userId in subtotalsPerUser) {
      const userTotal = subtotalsPerUser[userId] + (tax + tip) / Object.keys(subtotalsPerUser).length;
      $(`#grand-total-user-${userId}`).text(userTotal.toFixed(2));
    }
  }

  // Event bindings
  $(document).on('input', '.item-amount, .participant-amount, #tax_amount, #tip_amount', recalculateAmounts);
  $(document).on('change', '.equal-share-checkbox', function() {
    recalculateAmounts();
  });
  $(document).on('change', '.equal-share-checkbox', function() {
    var $checkbox = $(this);
    var $row = $checkbox.closest('.item-row');
    $row.find('.participant-amount').prop('disabled', $checkbox.is(':checked'));
    recalculateAmounts();
  });

  $(document).on('cocoon:after-remove', function(e, removed_item) {
    recalculateAmounts();
  });


  // Initial calculation
  recalculateAmounts();

  // Client-side validation
  // For the time being display simple alert, in full fledget application we can think of showing errors inline
  $('#new_expense_form').on('submit', function(e) {
    var isValid = true;
    $('.item-row').each(function() {
      var itemTitle = $(this).find('.item-title').val();
      var itemAmount = parseFloat($(this).find('.item-amount').val()) || 0;
      var paidById = $('#expense_paid_by_id').val();

      if (itemTitle.trim() === '' || itemAmount === 0) {
        isValid = false;
        alert('Item title and amount cannot be empty.');
        return false; // Break the loop
      }
      if (!paidById) {
        alert('Please select who paid for the expense.');
        isValid = false;
      }

      if (!$(this).find('.equal-share-checkbox').is(':checked')) {
        // Validate that user amounts match the item amount
        var totalParticipantAmount = 0;
        $(this).find('.participant-amount').each(function() {
          totalParticipantAmount += parseFloat($(this).val()) || 0;
        });

        if (totalParticipantAmount !== itemAmount) {
          isValid = false;
          alert('Participant amounts must equal the item amount.');
          return false; // Break the loop
        }
      }
    });

    if (!isValid) {
      e.preventDefault(); // Prevent form submission
      return false;
    }
  });

}); 