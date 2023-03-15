const currentTime = new Date();
const course = document.getElementsByClassName('course');

const handleGetDifferenceDay = (startDay, endDay) => {
    const millisBetween = startDay.getTime() - endDay.getTime();
    const days = millisBetween / (1000 * 3600 * 24);
    return Math.round(Math.abs(days));
}
for (let i = 0; i < course.length; i++) {
    const courseName = course[i].querySelector('.course-name')
    const progress = course[i].querySelector('.progress-bar')
    const start = course[i].querySelector('.start-time')
    const end = course[i].querySelector('.end-time')
    const startParts = start.innerHTML.split("/")
    const endParts = end.innerHTML.split("/")

    const startDate = new Date(+startParts[2], startParts[1] - 1, +startParts[0]);
    const endDate = new Date(+endParts[2], endParts[1] - 1, +endParts[0]);

    if (startDate > currentTime.getTime()) {
        progress.setAttribute("aria-valuenow", "0");
        progress.style.width = 0 + "%";

        const span = document.createElement('span');
        span.textContent = "Not Start Yet"
        span.classList.add("ms-2", "badge", "text-bg-danger")
        span.style.fontSize = "0.77rem"
        courseName.appendChild(span)
    } else if (endDate < currentTime.getTime()) {
        progress.setAttribute("aria-valuenow", "100");
        progress.style.width = "100%";
        progress.classList.add("bg-warning")
        const span = document.createElement('span');
        span.textContent = "Ended"
        span.classList.add("ms-2", "badge", "text-bg-warning")
        span.style.fontSize = "0.77rem"
        courseName.appendChild(span)
    } else {
        progress.classList.add("bg-success")
        const diffOfStartAndEndDate = handleGetDifferenceDay(startDate, endDate)
        const diffOfStartAndCurrentDate = handleGetDifferenceDay(startDate, currentTime)
        const progressWidth = diffOfStartAndCurrentDate/diffOfStartAndEndDate*100
        progress.setAttribute("aria-valuenow", `${progressWidth}`);
        progress.style.width = (progressWidth) + "%";

        const span = document.createElement('span');
        span.textContent = (diffOfStartAndCurrentDate - 1 > 0) ? `Started ${diffOfStartAndCurrentDate - 1} Days Ago` : `Start Today`
        span.classList.add("ms-2", "badge", "text-bg-success")
        span.style.fontSize = "0.77rem"
        courseName.appendChild(span)
    }
}