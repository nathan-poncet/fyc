## 20 Task.Supervisor
### 20.1 Cours
**Task.Supervisor** est utilisé pour superviser des tâches. Il est conçu spécifiquement pour superviser des processus de courte durée effectuant généralement une opération spécifique
#### 20.1.1 Exemple d'Utilisation
```elixir
defmodule MyTaskExample do
  def async_task(arg) do
    Task.Supervisor.start_child(MyApp.TaskSupervisor, fn ->
      # Fonction exécutée de manière asynchrone
      complex_operation(arg)
    end)
  end

  defp complex_operation(arg) do
    # Opération complexe
  end
end
```
Dans cet exemple, **MyTaskExample** utilise **Task.Supervisor** pour exécuter une opération complexe de manière asynchrone. **start_child** est utilisé pour démarrer la tâche sous la supervision de **MyApp.TaskSupervisor**.

#### 20.1.2 Documentation officielle
- [Task.Supervisor](https://hexdocs.pm/elixir/1.16/Task.Supervisor.html)

### 20.2 TP

#### 20.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/20%20-%20Task%20Supervisor/tp) :

Dans le module **Connect4Telnet.Endpoint** :
  - Ajoutez à la supervision un **TaskSupervisor** qui supervisera les connexions telnet
  - Modifiez la fonction `listen_loop/1` afin d'utiliser le **TaskSupervisor** pour démarrer une tâche qui gère la connexion telnet de l'utilisateur

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 20.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/20%20-%20Task%20Supervisor/correction).