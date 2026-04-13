document.addEventListener('DOMContentLoaded', () => {
    
    // --- CALENDAR LOGIC ---
    const monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    const daysOfWeek = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    
    let currentDate = new Date();
    let currentMonth = currentDate.getMonth();
    let currentYear = currentDate.getFullYear();
    
    let selectedFullDate = null; 
    let selectedTimeString = null;

    const monthDisplay = document.getElementById('current-month-display');
    const calendarGrid = document.getElementById('calendar-days-grid');
    const prevBtn = document.getElementById('prev-month');
    const nextBtn = document.getElementById('next-month');
    const dateLabel = document.getElementById('date-label');
    const hiddenInput = document.getElementById('selected-date');

    const today = new Date();
    today.setHours(0,0,0,0);

    function getAvailabilityForDay(dayOfWeek) {
        // 1 = Mon, 2 = Tue, 3 = Wed, 4 = Thu, 5 = Fri, 6 = Sat, 0 = Sun
        if (dayOfWeek === 2 || dayOfWeek === 3) {
            return ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30'];
        } else if (dayOfWeek === 4) {
            return ['15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00'];
        }
        return [];
    }

    function renderCalendar(month, year) {
        if(!calendarGrid) return;
        
        calendarGrid.innerHTML = ''; // Clear
        monthDisplay.textContent = `${monthNames[month]} ${year}`;

        // Add Day Headers
        daysOfWeek.forEach(day => {
            const header = document.createElement('div');
            header.style.fontWeight = '600';
            header.style.color = '#999';
            header.textContent = day;
            calendarGrid.appendChild(header);
        });

        // First day of the month
        let firstDay = new Date(year, month, 1).getDay();
        firstDay = firstDay === 0 ? 6 : firstDay - 1; 

        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const prevDaysInMonth = new Date(year, month, 0).getDate();

        // Previous month padding
        for (let i = firstDay; i > 0; i--) {
            const dayDiv = document.createElement('div');
            dayDiv.style.color = '#ccc';
            dayDiv.textContent = prevDaysInMonth - i + 1;
            calendarGrid.appendChild(dayDiv);
        }

        // Current month days
        for (let i = 1; i <= daysInMonth; i++) {
            const dayDate = new Date(year, month, i);
            const dayOfWeek = dayDate.getDay();
            const dayDiv = document.createElement('div');
            dayDiv.classList.add('cal-day');
            dayDiv.textContent = i;
            
            const isAvailableDay = dayOfWeek >= 2 && dayOfWeek <= 4;

            // Restrict to Tue(2), Wed(3), Thu(4)
            if (dayDate < today || !isAvailableDay) {
                dayDiv.style.color = '#ccc';
                dayDiv.style.cursor = 'not-allowed';
            } else {
                dayDiv.classList.add('available');
                
                if(selectedFullDate && 
                   selectedFullDate.getDate() === i && 
                   selectedFullDate.getMonth() === month && 
                   selectedFullDate.getFullYear() === year) {
                    dayDiv.classList.add('selected');
                }

                dayDiv.addEventListener('click', function() {
                    document.querySelectorAll('.cal-day.available').forEach(el => el.classList.remove('selected'));
                    this.classList.add('selected');
                    
                    selectedFullDate = new Date(year, month, i);
                    renderTimeSlots(dayOfWeek);
                    
                    const dayLabels = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"];
                    if (dateLabel) {
                        dateLabel.textContent = `${dayLabels[dayOfWeek]}, ${i} ${monthNames[month].substring(0,3)}`;
                    }
                });
            }
            calendarGrid.appendChild(dayDiv);
        }
    }

    function renderTimeSlots(dayOfWeek) {
        const slotsContainer = document.querySelector('.time-slots div');
        if (!slotsContainer) return;
        
        slotsContainer.innerHTML = '';
        const slots = getAvailabilityForDay(dayOfWeek);
        
        slots.forEach((time, index) => {
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'btn btn-time' + (index === 0 ? ' selected' : '');
            btn.textContent = time;
            btn.onclick = function() { selectTime(this, time); };
            slotsContainer.appendChild(btn);
            if (index === 0) {
                selectedTimeString = time;
                updateHiddenInput();
            }
        });
    }

    if(prevBtn && nextBtn) {
        prevBtn.addEventListener('click', () => {
            currentMonth--;
            if (currentMonth < 0) { currentMonth = 11; currentYear--; }
            renderCalendar(currentMonth, currentYear);
        });
        nextBtn.addEventListener('click', () => {
            currentMonth++;
            if (currentMonth > 11) { currentMonth = 0; currentYear++; }
            renderCalendar(currentMonth, currentYear);
        });
        
        // Initial render
        renderCalendar(currentMonth, currentYear);
    }

    window.selectTime = function(element, time) {
        document.querySelectorAll('.btn-time').forEach(el => el.classList.remove('selected'));
        element.classList.add('selected');
        selectedTimeString = time;
        updateHiddenInput();
    };

    function updateHiddenInput() {
        if(!hiddenInput) return;
        
        let val = '';
        if(selectedFullDate) {
            val += `${selectedFullDate.getDate()} ${monthNames[selectedFullDate.getMonth()]} ${selectedFullDate.getFullYear()}`;
        } else {
            val += 'Fecha sin seleccionar';
        }
        
        if(selectedTimeString) {
            val += ` - ${selectedTimeString}`;
        }
        hiddenInput.value = val;
    }

    // --- FORM SUBMISSION (AJAX) ---
    const contactForm = document.getElementById('call-form');
    const submitBtn = document.getElementById('call-submit-btn');
    const successMsg = document.getElementById('call-success-msg');
    const calLink = document.getElementById('google-cal-link');

    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!selectedFullDate || !selectedTimeString) {
                alert("Por favor, selecciona una fecha y hora.");
                return;
            }

            const formData = new FormData(this);
            submitBtn.disabled = true;
            submitBtn.textContent = "Procesando...";

            fetch(this.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => {
                if (response.ok) {
                    // Show success
                    contactForm.querySelectorAll('input, button:not(#google-cal-link)').forEach(el => el.style.display = 'none');
                    if (successMsg) successMsg.style.display = 'block';
                    
                    // Generate Google Cal Link
                    const start = new Date(selectedFullDate);
                    const [hours, minutes] = selectedTimeString.split(':');
                    start.setHours(hours, minutes, 0);
                    
                    const end = new Date(start);
                    end.setMinutes(end.getMinutes() + 30);
                    
                    const format = (d) => d.toISOString().replace(/-|:|\.\d+/g, '');
                    const gUrl = `https://calendar.google.com/calendar/render?action=TEMPLATE&text=Llamada%20con%20Little%20Juego%20Libre&dates=${format(start)}/${format(end)}&details=Confirmación%20de%20cita%20agendada%20desde%20la%20web.&location=Llamada%20Telefónica`;
                    
                    if (calLink) calLink.href = gUrl;
                } else {
                    alert("Error al agendar. Inténtalo de nuevo.");
                    submitBtn.disabled = false;
                    submitBtn.textContent = "Confirmar Reserva";
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Error de conexión. Inténtalo de nuevo.");
                submitBtn.disabled = false;
                submitBtn.textContent = "Confirmar Reserva";
            });
        });
    }
    
    // Initial sync
    const activeTime = document.querySelector('.btn-time.selected');
    if(activeTime) {
        selectedTimeString = activeTime.textContent.trim();
        updateHiddenInput();
    }
});
