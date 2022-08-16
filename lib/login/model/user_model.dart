bool login(String username, String password) {
  return usersDb[username.toLowerCase().trim()] == password.trim();
}

const usersDb = {
  'alice': 'password',
  'bob': 'password2',
  'admin': 'admin',
};
