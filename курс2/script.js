// Данные вынесены в массивы, чтобы интерфейс было легко расширять
// или подключать позже к API / базе данных.
const orders = [
  {
    id: "#FF-1024",
    customer: "Анна Смирнова",
    address: "ул. Лесная, 14",
    status: "Готовится",
    statusClass: "cooking",
    eta: "18 мин",
    courier: "Илья",
    items: ["Том ям", "Ролл с лососем", "Манго-лимонад"]
  },
  {
    id: "#FF-1025",
    customer: "Максим Орлов",
    address: "пр. Победы, 7",
    status: "Передан курьеру",
    statusClass: "delivery",
    eta: "11 мин",
    courier: "София",
    items: ["Бургер BBQ", "Картофель фри", "Кола"]
  },
  {
    id: "#FF-1026",
    customer: "Елена Петрова",
    address: "наб. Речная, 22",
    status: "Срочный заказ",
    statusClass: "urgent",
    eta: "9 мин",
    courier: "Артур",
    items: ["Поке с тунцом", "Мисо суп"]
  }
];

const workers = [
  {
    name: "София Белова",
    role: "Курьер",
    shift: "08:00 - 20:00",
    load: 82,
    task: "3 доставки в пути"
  },
  {
    name: "Данил Миронов",
    role: "Оператор",
    shift: "09:00 - 21:00",
    load: 56,
    task: "Обрабатывает входящие звонки"
  },
  {
    name: "Мария Волкова",
    role: "Кухня",
    shift: "10:00 - 22:00",
    load: 74,
    task: "Контроль горячего цеха"
  },
  {
    name: "Илья Громов",
    role: "Курьер",
    shift: "07:00 - 19:00",
    load: 67,
    task: "2 заказа на маршруте"
  }
];

const comments = [
  {
    author: "Оператор Антон",
    time: "12:05",
    text: "Клиент по заказу #FF-1024 попросил добавить приборы и соус к основному набору."
  },
  {
    author: "Кухня",
    time: "12:11",
    text: "Заготовка роллов завершена, задержек по горячим позициям сейчас нет."
  },
  {
    author: "Логистика",
    time: "12:16",
    text: "На северном районе плотный трафик, время доставки может вырасти на 5-7 минут."
  }
];

const ordersList = document.getElementById("orders-list");
const workersList = document.getElementById("workers-list");
const commentsList = document.getElementById("comments-list");

function renderOrders() {
  ordersList.innerHTML = orders
    .map((order) => {
      const itemsMarkup = order.items.map((item) => `<li>${item}</li>`).join("");

      return `
        <article class="order-card">
          <div class="order-card__top">
            <div>
              <h3>${order.id}</h3>
              <p>${order.customer}</p>
            </div>
            <span class="status-pill status-pill--${order.statusClass}">${order.status}</span>
          </div>

          <div class="order-card__meta">
            <span class="meta-chip">Адрес: ${order.address}</span>
            <span class="meta-chip">ETA: ${order.eta}</span>
            <span class="meta-chip">Курьер: ${order.courier}</span>
          </div>

          <ul class="order-card__items">
            ${itemsMarkup}
          </ul>
        </article>
      `;
    })
    .join("");
}

function renderWorkers() {
  workersList.innerHTML = workers
    .map((worker) => {
      const initials = worker.name
        .split(" ")
        .map((part) => part[0])
        .join("")
        .slice(0, 2);

      return `
        <article class="worker-card">
          <div class="worker-card__top">
            <div class="worker-card__top" style="align-items:center;">
              <div class="worker-card__avatar">${initials}</div>
              <div>
                <h3>${worker.name}</h3>
                <p>${worker.role}</p>
              </div>
            </div>
            <span class="meta-chip">${worker.shift}</span>
          </div>

          <div class="worker-card__meta">
            <span>${worker.task}</span>
            <span>Загрузка: ${worker.load}%</span>
          </div>

          <div class="worker-card__progress" aria-label="Загрузка сотрудника ${worker.load}%">
            <span style="width:${worker.load}%"></span>
          </div>
        </article>
      `;
    })
    .join("");
}

function renderComments() {
  commentsList.innerHTML = comments
    .map(
      (comment) => `
        <article class="comment-card">
          <div class="comment-card__top">
            <span class="comment-card__author">${comment.author}</span>
            <span class="comment-card__time">${comment.time}</span>
          </div>
          <p class="comment-card__text">${comment.text}</p>
        </article>
      `
    )
    .join("");
}

// Первичная отрисовка всех блоков после загрузки страницы.
renderOrders();
renderWorkers();
renderComments();
