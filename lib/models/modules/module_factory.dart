import 'module.dart';
import 'templates.dart';

class ModuleFactory {
  static const Map<Type, ModuleTemplate> _moduleTemplates = {
    DockModuleTemplate: const DockModuleTemplate(),
    StorageModuleTemplate: const StorageModuleTemplate(),
  };

  static Map<Type, SubmoduleTemplate> _submoduleTemplates = {
    FuelingSubmoduleTemplate: const FuelingSubmoduleTemplate(),
  };

  static List<ModuleTemplate> get moduleTemplates => _moduleTemplates.values.toList();
  static List<SubmoduleTemplate> get submoduleTemplates => _submoduleTemplates.values.toList();

  static ModuleState<T> createDefaultModuleTemplateState<T extends ModuleTemplate>({
    List<SubmoduleState<SubmoduleTemplate<T>, T>> submoduleStates
  }) {
    assert(_moduleTemplates.containsKey(T), 'Module of Type $T is missing from ModuleTemplates!');
    ModuleState<T> state = _moduleTemplates[T].createDefaultState();
    if (submoduleStates != null) {
      for (SubmoduleState submoduleState in submoduleStates) {
        state.addSubmodule<SubmoduleTemplate<T>>(submoduleState);
      }
    }
    return state;
  }

  static SubmoduleState<T, K> createDefaultSubmoduleTemplateState<T extends SubmoduleTemplate<K>, K extends ModuleTemplate>() {
    assert(_submoduleTemplates.containsKey(T), 'Module of Type $T is missing from ModuleTemplates!');
    return _submoduleTemplates[T].createDefaultState();
  }

  static T getModuleTemplate<T extends ModuleTemplate>() {
    assert(_moduleTemplates.containsKey(T), 'Module of Type $T is missing from ModuleTemplates!');
    return _moduleTemplates[T] as T;
  }

  static T getSubmoduleTemplate<T extends SubmoduleTemplate>() {
    assert(_submoduleTemplates.containsKey(T), 'SubmoduleModule of Type $T is missing from SubmoduleTemplates!');
    return _submoduleTemplates[T] as T;
  }
}