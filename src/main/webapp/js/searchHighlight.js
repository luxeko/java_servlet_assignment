function search(){
    let search_users = document.getElementById('search_users').value;
    const tbody_list_user = document.getElementById('tbody_list_user');
    search_users = search_users.replace(/[.*+?^${}()|[\]\\]/g,"\\$&");
    let pattern = new RegExp(`${search_users}`,"gi");
    tbody_list_user.innerHTML = tbody_list_user.textContent.replace(pattern, match => `<mark>${match}</mark>`)
}