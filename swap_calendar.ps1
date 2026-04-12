$file = "c:\Users\tonip\Desktop\LITTLE\contacto.html"
$content = Get-Content $file -Raw -Encoding UTF8

$search = @"
                                <div class="calendar-header"
                                    style="background: var(--color-bg-primary); padding: 10px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee;">
                                    <button type="button" class="btn"
                                        style="padding: 5px; background: none; color: var(--color-text-main);"><span
                                            class="material-symbols-rounded">chevron_left</span></button>
                                    <span style="font-weight: 600; font-size: 0.9rem;" data-i18n="contact_month">Agosto
                                        2026</span>
                                    <button type="button" class="btn"
                                        style="padding: 5px; background: none; color: var(--color-text-main);"><span
                                            class="material-symbols-rounded">chevron_right</span></button>
                                </div>
                                <div class="calendar-grid"
                                    style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 2px; padding: 10px; text-align: center; font-size: 0.9rem;">
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_mon">L</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_tue">M</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_wed">X</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_thu">J</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_fri">V</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_sat">S</div>
                                    <div style="font-weight: 600; color: #999;" data-i18n="contact_sun">D</div>
                                    <div style="color: #ccc;">27</div>
                                    <div style="color: #ccc;">28</div>
                                    <div style="color: #ccc;">29</div>
                                    <div style="color: #ccc;">30</div>
                                    <div style="color: #ccc;">31</div>
                                    <div class="cal-day">1</div>
                                    <div class="cal-day">2</div>
                                    <div class="cal-day">3</div>
                                    <div class="cal-day">4</div>
                                    <div class="cal-day">5</div>
                                    <div class="cal-day">6</div>
                                    <div class="cal-day">7</div>
                                    <div class="cal-day">8</div>
                                    <div class="cal-day">9</div>
                                    <div class="cal-day available">10</div>
                                    <div class="cal-day available">11</div>
                                    <div class="cal-day">12</div>
                                    <div class="cal-day">13</div>
                                    <div class="cal-day">14</div>
                                    <div class="cal-day">15</div>
                                    <div class="cal-day available" onclick="selectDate(this, '16')">16</div>
                                    <div class="cal-day available selected" id="default-selected" onclick="selectDate(this, '17')">17</div>
                                    <div class="cal-day available" onclick="selectDate(this, '18')">18</div>
                                    <div class="cal-day">19</div>
                                    <div class="cal-day">20</div>
                                    <div class="cal-day">21</div>
                                    <div class="cal-day">22</div>
                                    <div class="cal-day available" onclick="selectDate(this, '23')">23</div>
                                    <div class="cal-day available" onclick="selectDate(this, '24')">24</div>
                                    <div class="cal-day available" onclick="selectDate(this, '25')">25</div>
                                    <div class="cal-day">26</div>
                                    <div class="cal-day">27</div>
                                    <div class="cal-day">28</div>
                                </div>
"@

$replace = @"
                                <div class="calendar-header"
                                    style="background: var(--color-bg-primary); padding: 10px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee;">
                                    <button type="button" class="btn" id="prev-month"
                                        style="padding: 5px; background: none; color: var(--color-text-main);"><span
                                            class="material-symbols-rounded">chevron_left</span></button>
                                    <span style="font-weight: 600; font-size: 0.9rem;" id="current-month-display"></span>
                                    <button type="button" class="btn" id="next-month"
                                        style="padding: 5px; background: none; color: var(--color-text-main);"><span
                                            class="material-symbols-rounded">chevron_right</span></button>
                                </div>
                                <div class="calendar-grid" id="calendar-days-grid"
                                    style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 2px; padding: 10px; text-align: center; font-size: 0.9rem;">
                                    <!-- Dynamic Calendar goes here -->
                                </div>
"@

$content = $content.Replace($search, $replace)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Calendar HTML updated!"
