$('.container').hide();

let progressInterval;
let percentageInterval;

window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.action) {
        case "hide":
            $(".form").hide();
            break;
        case "show":
            $(".form").show();
            break;
        case "infos":
            $(".job").text(data.job);
            $(".rang").text(data.rang);
            $(".street").text(data.street);
            $(".plz").text(data.plz);
            break;

        case "progress":
            if ($('.container').is(':visible')) {
                clearInterval(progressInterval);
                clearInterval(percentageInterval);
                $('.container').stop(true, true).hide();
                $('.loading-bar--progress span').css('opacity', '0');
                $('.1').css('opacity', '1');
                $('.percentage').text('0%');
                $('.x').css('opacity', '0.25');
            }

            const time = data.time;
            const msg = data.msg;
            const stopMsg = data.stopMsg !== undefined ? data.stopMsg : 'Drücke E um abzubrechen';
            let current = 0;
            let percentage = 0;
            const totalSpans = 5;

            $('.container').fadeIn(100); 

            $('.msg').text(msg)
            $('.stopMsg').text(stopMsg)
            
            progressInterval = setInterval(() => {
                if (current < totalSpans) {
                    $(`.loading-bar--progress span`).eq(current).css('opacity', '1');
                    current++;
                } else {
                    clearInterval(progressInterval);
                }
            }, time / totalSpans);

            percentageInterval = setInterval(() => {
                if (percentage < 100) {
                    percentage++;
                    $(".percentage").text(`${percentage}%`);
                } else {
                    clearInterval(percentageInterval);
                    $('.container').fadeOut(100);
                    setTimeout(() => {
                        $('.x').css('opacity', '0.25');
                        $('.container').hide();
                    }, 100);
                }
            }, time / 100);
            break;
    }
});
