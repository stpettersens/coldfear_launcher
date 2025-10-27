/*
  Launcher for Cold Fear which backs up save games on exit.

  ***************************************************
  Rename the original executable to coldfear_game.exe
  ***************************************************

  Requires 7z to create save game archive
  and copyparty_sync to upload to a copyparty server.
*/

import std.stdio;
import std.process;

void print_title() {
    string[] lines = [
        r"",
        r"",
        r"                     DARKWORKS PRESENTS",
        r"",
        r"   _____ ____  _      _____    ______ ______          _____",
        r"  / ____/ __ \| |    |  __ \  |  ____|  ____|   /\   |  __ \ ",
        r" | |   | |  | | |    | |  | | | |__  | |__     /  \  | |__) |",
        r" | |   | |  | | |    | |  | | |  __| |  __|   / /\ \ |  _  /",
        r" | |___| |__| | |____| |__| | | |    | |____ / ____ \| | \ \",
        r"  \_____\____/|______|_____/  |_|    |______/_/    \_\_|  \_\",
        r"",
        r"",
        r"Unoffical Launcher by Sam Saint-Pettersen (v0.1.0)",
        r"",
        r""
    ];

    foreach (l; lines) {
        writeln(l);
    }
}

int main() {
    int exit_code = -1;
    print_title();
    writeln("Launching game executable...");
    auto game = execute("coldfear_game.exe");
    if (game.status == 0) {
        writeln("Archiving save data...");
        auto archive = executeShell(r"7z u COLDFEAR_SAVES.7z SAVES\*");
        writeln(archive.output);
        if (archive.status == 0) {
            writeln("Uploading save data...");
            auto upload = executeShell("copyparty_sync");
            writeln(upload.output);
            if (upload.status == 0) exit_code = 0;
            else writeln("FAILED to upload game save(s) archive.");
        }
        else writeln("FAILED to archive game save(s).");

    }
    else writeln("FAILED to execute game.");
    write("Press any key to continue.");
    char c;
    readf("%c", &c);
    writeln();
    return exit_code;
}
