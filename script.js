// Veritabanı Simülasyonu
let users = [
    { name: "Ahmet Yılmaz", role: "Personel", status: "Giriş Yapmadı" },
    { name: "Mehmet Demir", role: "Yönetici", status: "Çalışıyor" }
];

let currentUser = null;

// Ekran Değiştirme Fonksiyonu
function showScreen(screenId) {
    document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
    document.getElementById(screenId).classList.add('active');
}

// Normal Giriş
function login() {
    const id = document.getElementById('login-id').value.trim();
    const pass = document.getElementById('login-pass').value.trim();

    if(id && pass) {
        currentUser = { name: "Ahmet Yılmaz", role: "Personel" };
        setupDashboard();
    } else {
        alert("Lütfen alanları doldurun!");
    }
}

// Patron Giriş Modalı
function openBossModal() { document.getElementById('boss-modal').style.display = 'flex'; }
function closeBossModal() { document.getElementById('boss-modal').style.display = 'none'; }

function bossLogin() {
    const user = document.getElementById('boss-user').value;
    const pass = document.getElementById('boss-pass').value;

    if(user === "admin" && pass === "1234") {
        closeBossModal();
        currentUser = { name: "Sistem Patronu", role: "Patron" };
        setupDashboard();
    } else {
        alert("Hatalı Patron Bilgisi! (admin / 1234)");
    }
}

// Dashboard Ayarları ve Yetki Kontrolü
function setupDashboard() {
    document.getElementById('welcome-name').innerText = `Hoşgeldin, ${currentUser.name}`;
    document.getElementById('welcome-role').innerText = `Yetki Seviyesi: ${currentUser.role}`;
    document.getElementById('panel-title').innerText = `NetMesai (${currentUser.role} Paneli)`;

    // Yönetici veya Patron ise Personel Yönetim menüsünü göster
    const adminCard = document.getElementById('admin-menu-card');
    if(currentUser.role === "Patron" || currentUser.role === "Yönetici") {
        adminCard.style.display = "block";
    } else {
        adminCard.style.display = "none";
    }

    showScreen('dashboard-screen');
}

function logout() {
    currentUser = null;
    showScreen('login-screen');
}

function backToDashboard() {
    showScreen('dashboard-screen');
}

// PDKS QR İşlemleri ("123" Kodu)
function openPdks() { showScreen('pdks-screen'); }

function verifyQr() {
    const code = document.getElementById('qr-input').value.trim();
    const resultText = document.getElementById('qr-result');

    if(code === "123") {
        resultText.innerHTML = "✅ Başarılı! Giriş/Çıkış onaylandı.";
        resultText.style.color = "green";
    } else {
        resultText.innerHTML = "❌ Geçersiz Kod! Doğru kod: 123";
        resultText.style.color = "red";
    }
}

// Personel Yönetimi Ekranı
function openPersonnel() {
    renderPersonnelList();
    showScreen('personnel-screen');
}

function renderPersonnelList() {
    const listEl = document.getElementById('personnel-list');
    listEl.innerHTML = "";

    users.forEach((u, index) => {
        listEl.innerHTML += `
            <li class="user-item">
                <div>
                    <strong>${u.name}</strong><br>
                    <small>Rol: ${u.role} | Durum: ${u.status}</small>
                </div>
                <button onclick="deleteUser(${index})" style="background:none; border:none; color:red; cursor:pointer;"><i class="fa-solid fa-trash"></i></button>
            </li>
        `;
    });
}

function openAddUserModal() { document.getElementById('add-user-modal').style.display = 'flex'; }
function closeAddUserModal() { document.getElementById('add-user-modal').style.display = 'none'; }

function addUser() {
    const name = document.getElementById('new-name').value.trim();
    const role = document.getElementById('new-role').value;

    if(name) {
        users.push({ name: name, role: role, status: "Aktif Değil" });
        closeAddUserModal();
        renderPersonnelList();
    } else {
        alert("Lütfen isim girin.");
    }
}

function deleteUser(index) {
    users.splice(index, 1);
    renderPersonnelList();
}

function openShifts() {
    alert("Vardiya Programı ekranı açılıyor.");
}

