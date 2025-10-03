// URL de la API para obtener categorías
const API_URL = 'http://localhost/API_PHP_ROMERO/controller/';

// Cargar categorías cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    loadCategories();
});

// Botón para volver a categorías
document.getElementById('back-to-categories').addEventListener('click', () => {
    document.getElementById('products-list').style.display = 'none';
    document.getElementById('category-list').style.display = 'block';
});

// Función para cargar categorías
async function loadCategories() {
    const container = document.getElementById('categories-container');
    container.innerHTML = 'Cargando categorías...';
    try {
        const response = await fetch(`${API_URL}categoria.php?op=GetAll`);
        const categories = await response.json();
        container.innerHTML = ''; // Limpiar el mensaje de carga
        
        if (categories.length > 0) {
            categories.forEach(cat => {
                const li = document.createElement('li');
                li.classList.add('category-item');
                li.textContent = cat.cat_nombre;
                li.onclick = () => loadProducts(cat.cat_id, cat.cat_nom);
                container.appendChild(li);
            });
        } else {
            container.innerHTML = '<p>No se encontraron categorías.</p>';
        }
    } catch (error) {
        console.error('Error al cargar las categorías:', error);
        container.innerHTML = '<p>Error al cargar las categorías. Inténtalo de nuevo más tarde.</p>';
    }
}

async function loadProducts(catId, catNom) {
const productsContainer = document.getElementById('products-container');
const productsTitle = document.getElementById('products-list').querySelector('h2');

document.getElementById('category-list').style.display = 'none';
document.getElementById('products-list').style.display = 'block';
productsTitle.textContent = `Productos de: ${catNom}`;
productsContainer.innerHTML = 'Cargando productos...';

try{

    const response = await fetch(`${API_URL}producto.php?op=GetxCat`,{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({cat_id: catId})
    });
    const products = await response.json();
    productsContainer.innerHTML = ''; // Limpiar el mensaje de carga

    if(products.length > 0){
        products.forEach(prod => {
            const card = document.createElement('div');
            card.classList.add('product-card');
            card.innerHTML = `
                <h3>${prod.prod_nom}</h3>
                <p>${prod.prod_desc}</p>
                <p><strong>Precio:</strong>$${prod.prod_precio}</p>
            `;
            productsContainer.appendChild(card);
        });
    }else{
        productsContainer.innerHTML = '<p>No se encontraron productos en esta categoría.</p>';
    }
} catch (error) {
    console.error('Error al cargar los productos:', error);
    productsContainer.innerHTML = '<p>Error al cargar los productos. Inténtalo de nuevo más tarde.</p>';
}

}