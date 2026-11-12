part of '../main.dart';

// Componentes visuais reutilizados nas telas existentes.
extension ComponentesApp on AplicativoState {
  Widget botao(String texto, VoidCallback acao, {bool contorno = false}) =>
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: contorno
              ? OutlinedButton(
                  onPressed: acao,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: roxo,
                    side: const BorderSide(color: roxo),
                  ),
                  child: Text(texto),
                )
              : FilledButton(
                  onPressed: acao,
                  style: FilledButton.styleFrom(backgroundColor: roxo),
                  child: Text(texto),
                ),
        ),
      );
  Widget campo(
    String titulo,
    TextEditingController controle, {
    int linhas = 1,
    bool senha = false,
    String? dica,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controle,
      maxLines: linhas,
      obscureText: senha,
      decoration: InputDecoration(
        labelText: titulo,
        hintText: dica,
        filled: true,
        fillColor: fundo,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
  Widget bloco(
    String titulo,
    String subtitulo,
    VoidCallback acao, {
    IconData icone = Icons.work_outline,
    String? botaoTexto,
  }) => Card(
    color: fundo,
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE7E2FF),
        child: Icon(icone, color: roxo),
      ),
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitulo),
      trailing: const Icon(Icons.chevron_right),
      onTap: acao,
    ),
  );
  Widget titulo(String texto) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(
      texto,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
  Widget pagina(
    String nome,
    List<Widget> filhos, {
    bool menu = true,
    bool voltarTopo = true,
  }) => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/img/logo.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) => const Text(
              'SkillMatch',
              style: TextStyle(color: roxo, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => ir('notificacoes'),
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () => ir('configuracoes'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            if (voltarTopo)
              InkWell(
                onTap: () => voltar(),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 18),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Text(
                  nome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 14),
            ...filhos,
          ],
        ),
      ),
    ),
    bottomNavigationBar: menu
        ? NavigationBar(
            height: 68,
            selectedIndex: aba,
            onDestinationSelected: navegar,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Início',
              ),
              NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Cursos',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
          )
        : null,
  );
  Widget formulario(
    String nomeTela,
    List<String> rotulos,
    void Function(List<String>) salvar, {
    String? descricaoTopo,
    List<String>? iniciais,
  }) {
    final controles = List.generate(
      rotulos.length,
      (i) => TextEditingController(
        text: iniciais != null && i < iniciais.length ? iniciais[i] : '',
      ),
    );
    return pagina(nomeTela, [
      if (descricaoTopo != null) Text(descricaoTopo),
      ...List.generate(
        rotulos.length,
        (i) => campo(
          rotulos[i],
          controles[i],
          linhas:
              rotulos[i].toLowerCase().contains('descrição') ||
                  rotulos[i].toLowerCase().contains('mensagem')
              ? 3
              : 1,
        ),
      ),
      botao('Salvar e continuar', () {
        if (controles.any((c) => c.text.trim().isEmpty)) {
          aviso('Preencha todos os campos.');
          return;
        }
        salvar(controles.map((c) => c.text.trim()).toList());
      }),
    ], menu: false);
  }

  Widget acesso(String modo) {
    final login = modo == 'login';
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Image.asset('assets/img/logo.png', height: 53)),
                  const SizedBox(height: 22),
                  Text(
                    login
                        ? 'Conectando talento a\nnovas oportunidades!'
                        : 'Crie sua conta!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 30),
                  campo('E-mail', emailAcesso),
                  campo('Senha', senhaAcesso, senha: true),
                  if (!login)
                    campo('Confirmar senha', confirmarAcesso, senha: true),
                  if (login)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => ir('recuperar_senha'),
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  botao(login ? 'Entrar' : 'Continuar', () => _enviarAcesso(login)),
                  const SizedBox(height: 16),
                  if (login) ...[
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text('ou'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                  if (login)
                    botao(
                      'Criar uma conta',
                      () => ir('cadastro'),
                      contorno: true,
                    )
                  else
                    Center(
                      child: TextButton(
                        onPressed: () => ir('login'),
                        child: const Text('Já possui uma conta? Entrar'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
