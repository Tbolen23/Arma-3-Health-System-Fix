class CfgPatches {
    class ace_damage_mod {
        name = "ACE Damage Modifier";
        author = "Tbolen23";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"cba_main", "ace_medical", "ace_medical_damage"};
        version = "2.0.2";
        versionStr = "2.0.2";
        versionAr[] = {2,0,2};
    };
};

class CfgFunctions {
    class ace_damage_mod {
        tag = "ace_dmg";
        class functions {
            file = "\z\ace_dmg\addons\ace_damage_mod\functions";
            class init {
                postInit = 1;
            };
            class handleDamage {};
            class handleExplosion {};
        };
    };
};
