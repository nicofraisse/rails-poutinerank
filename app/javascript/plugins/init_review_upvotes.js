const initReviewUpvotes = () => {
  document.querySelectorAll('.card-review-info-personal').forEach((pack) => {
    var upvoted = false;
    var downvoted = false;
    const upButton = pack.querySelector('#upEnabled-' + pack.dataset.id)
    const downButton = pack.querySelector('#downEnabled-' + pack.dataset.id);
    pack.querySelector('.btn-upvote').addEventListener(('click'), (e) => {
      if (upvoted == false && downvoted == true) {
        pack.querySelector('.no-upvotes').innerHTML = parseInt(pack.querySelector('.no-upvotes').innerHTML) + 2;
        pack.querySelector('.btn-upvote').classList.add('upvoted');
        pack.querySelector('.btn-downvote').classList.remove('downvoted');
        upButton.value = 'trueChangedMyMind'
        downButton.value = 'true';
        upvoted = true;
        downvoted = false;
      } else if (upvoted == false && downvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML++;
        pack.querySelector('.btn-upvote').classList.add('upvoted');
        upButton.value = 'true';
        downButton.value = 'true';
        upvoted = true;
      } else if (upvoted == true && downvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML--;
        pack.querySelector('.btn-upvote').classList.remove('upvoted');
        upButton.value = 'trueSpam';
        downButton.value = 'true';
        upvoted = false;
      }
    })
    pack.querySelector('.btn-downvote').addEventListener(('click'), (e) => {
      if (downvoted == false && upvoted == true) {
        pack.querySelector('.no-upvotes').innerHTML -= 2;
        pack.querySelector('.btn-downvote').classList.add('downvoted');
        pack.querySelector('.btn-upvote').classList.remove('upvoted');
        upButton.value = 'true'
        downButton.value = 'trueChangedMyMind';
        downvoted = true;
        upvoted = false;
      } else if (downvoted == false && upvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML--;
        pack.querySelector('.btn-downvote').classList.add('downvoted');
        upButton.value = 'true'
        downButton.value = 'true';
        downvoted = true;
      } else if (downvoted == true && upvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML++;
        pack.querySelector('.btn-downvote').classList.remove('downvoted');
        upButton.value = 'true'
        downButton.value = 'trueSpam';
        downvoted = false;
      }
    })
  })
};

export { initReviewUpvotes };
