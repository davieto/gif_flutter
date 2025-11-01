🎬 GIFlix — Aplicativo Flutter de GIFs Animados

Aplicativo completo desenvolvido em Flutter, que permite buscar, visualizar e organizar GIFs da API do Giphy, com suporte a temas dinâmicos, favoritos, coleções personalizadas, histórico de busca e persistência local via Hive e SharedPreferences.

─────────────────────────────
🚀 FUNCIONALIDADES

✅ Busca por GIFs com integração Giphy e debounce (evita requisições seguidas)
✅ Tendências (Trending) exibidas automaticamente
✅ Favoritos com armazenamento local persistente (Hive)
✅ Coleções personalizadas — organize seus GIFs do jeito que quiser
✅ Histórico de buscas salvo e acessível localmente
✅ Configurações completas:
 - Modo escuro / claro 🌙
 - Reprodução automática 🔁
 - Idioma dos resultados 🌐
 - Tamanho dos GIFs 🎞️
 - Cor principal do app 🌈 (rosa, azul, roxo, verde)
 - Limpar dados locais (histórico e favoritos) 🗑️

✅ Paginação e estados de tela:
 - carregando (LoadingView)
 - erros (ErrorView)
 - vazios (EmptyView)

✅ Arquitetura em camadas:
lib/
├── core/
├── data/
├── domain/
├── application/
└── presentation/

✅ Persistência local com Hive e SharedPreferences
✅ Gerência de estado com Riverpod — reatividade total sem boilerplate

─────────────────────────────
🏗️ ARQUITETURA

Camada         | Descrição
---------------|-----------------------------------------
core           | Constantes, utilidades e classes base (ex: Debouncer, ApiConstants)
data           | DataSources (remotos e locais), modelos e repositórios
domain         | Entidades e casos de uso (usecases)
application    | Gerenciamento de estado (providers com StateNotifier)
presentation   | Telas, widgets, temas e UX/UI

─────────────────────────────
💾 PERSISTÊNCIA

Hive:
 - preferences: salva cor do tema, idioma, modo escuro
 - favorites: armazena GIFs favoritados
 - history: salva histórico de buscas

SharedPreferences:
 - usado para armazenamento leve de coleções de GIFs

─────────────────────────────
🎨 TEMA DINÂMICO

O usuário pode alterar a cor principal do app em tempo real:
→ Rosa, Azul, Verde ou Roxo

Afeta:
 - AppBar (Header)
 - Ícones do topo
 - Cartões de Coleção
 - Botões principais

Inclui também modo claro e escuro personalizados.

─────────────────────────────
⚙️ TECNOLOGIAS UTILIZADAS

Biblioteca                      | Função
--------------------------------|----------------------------
flutter_riverpod                | Gerência de estado reativa
hive / hive_flutter             | Persistência local
shared_preferences              | Configurações simples e coleções
http                            | Requisições à API do Giphy
flutter_staggered_grid_view     | Layout responsivo de GIFs
flutter/material.dart           | UI moderna e responsiva

─────────────────────────────
🧪 COMO EXECUTAR

1️⃣ Clone o repositório:
   git clone <repositorio>
   cd gif_flutter

2️⃣ Instale dependências:
   flutter pub get

3️⃣ Rode o aplicativo:
   flutter run (Obs: O banco so manterá os dados na opção windows)

─────────────────────────────
📁 ESTRUTURA DO PROJETO

lib/
├── core/
│   ├── constants/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── database/
│   ├── models/
│   ├── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── application/
│   └── state/
└── presentation/
    ├── pages/
    ├── themes/
    └── widgets/

─────────────────────────────
🧩 DIVISÃO DE RESPONSABILIDADES

Componente                    | Responsabilidade
------------------------------|--------------------------------------
GiphyRemoteDataSource          | Chamadas HTTP para buscar GIFs
GifRepositoryImpl              | Ponte entre data sources e usecases
Providers (StateNotifiers)     | Controlam estado e ações
Presentation Layer             | Exibe dados, trata estados e interação

─────────────────────────────
🧠 DECISÕES DE DESIGN

- Riverpod: integração fluida com Flutter 3 e null‑safety
- Hive: alta performance offline
- SharedPreferences: ideal para configurações simples
- Arquitetura modular e escalável
- Theming dinâmico para maior personalização visual

─────────────────────────────
👥 AUTORES / GRUPO

Group 7 — Projeto GIFlix
Integrantes: Davi Chagas, Natalia Matricardi, João Antonio, Cristian Roberto, Luan Gabryel, Mauricio Simões
Desenvolvedores ativos: Davi Chagas de Oliveira e Natalia Matricardi
Professor: Jefferson Rodrigo Speck

─────────────────────────────
🏁 CONCLUSÃO

O projeto cumpre todos os requisitos:
✅ Executável e estável
✅ Arquitetura clara e camadas bem definidas
✅ Funcionalidades completas (busca, histórico, favoritos, configurações, coleções)
✅ Persistência local consistente
✅ UX moderna e adaptável às preferências do usuário

─────────────────────────────
💬 “GIFs, mas com estilo e persistência — GIFlix by Group 7 😎”