# SkillMatch — Capacitação e oportunidades para freelancers

Aplicativo acadêmico em **Flutter** que aproxima freelancers iniciantes de oportunidades de trabalho, com perfis para **Freelancer** e **Cliente**. O protótipo inclui navegação, catálogo de cursos, oportunidades, envio e acompanhamento de propostas, portfólio e notificações.

## Equipe
- Ana Júlia Monteiro Lemes
- Júlio Félix Quintero de Assis
- Thamiris Bernal Molina

Universidade de Mogi das Cruzes (UMC).

## Tecnologias
- Flutter e Dart (Material 3)
- Interface responsiva para execução no Chrome
- Fonte Poppins e recursos locais em `assets/`

## Executar
1. Instale o Flutter SDK e verifique com `flutter doctor`.
2. Abra a pasta `skill_match` no VS Code ou terminal.
3. Execute:

```bash
flutter pub get
flutter run -d chrome
```

Para verificar a análise estática:

```bash
flutter analyze
```

## Estrutura
- `lib/main.dart`: fluxo de telas e lógica de interação da demonstração
- `lib/models/`: modelos de oportunidade e proposta
- `lib/data/`: dados iniciais de demonstração
- `lib/theme/`: cores compartilhadas
- `lib/view/` e `lib/controller/`: componentes e arquivos de apoio existentes
- `assets/`: logo e fontes

## Fluxos para testar
1. Boas-vindas → cadastro ou login → seleção de tipo de conta.
2. Freelancer → buscar oportunidades → visualizar detalhes → enviar proposta → minhas propostas.
3. Cliente → publicar oportunidade → minhas oportunidades → visualizar e excluir oportunidade.
4. Navegar pelas abas Início, Buscar, Cursos e Perfil; abrir detalhes de cursos e editar portfólio.

## Limitações conhecidas
**Protótipo acadêmico:** login e recuperação de senha não estão integrados a um provedor de autenticação; os dados de oportunidades e propostas são mantidos apenas durante a execução, sem banco de dados. Não utilize credenciais reais. As telas de alteração de senha são demonstrativas.

## Capturas de tela
Adicionar capturas reais de boas-vindas, login, home freelancer, home cliente, oportunidades e cursos antes da entrega no GitHub.

## Versionamento
Publique o código em repositório GitHub e faça commits descritivos por integrante.


## Persistência local (etapa 2)

O app usa `shared_preferences` para armazenar no dispositivo/navegador um snapshot JSON do perfil, oportunidades e propostas. Publicações, exclusões e envio de propostas atualizam o armazenamento. Ao abrir o aplicativo novamente, os dados locais são carregados.

**Limitações:** este mecanismo não é um banco SQL, não sincroniza entre dispositivos, não é adequado para grandes volumes de dados e não constitui autenticação. O formulário de login ainda é demonstrativo e **senhas não são persistidas**. Para usuários reais e login seguro, integrar um backend de autenticação e banco de dados (por exemplo, Firebase Auth + Firestore).

Teste: `flutter pub get`, `flutter analyze`, `flutter run -d chrome`. Publique uma oportunidade, recarregue a página e confirme sua presença. Teste também exclusão e envio de proposta.
