_:
let
  repos = [
    "Api.Lib"
    "AuditApi"
    "ComputationApi"
    "frontend"
    "ImportApi"
    "IntegrationApi"
    "LedgerApi"
    "monitor"
    "PublicApi"
    "ReferentialApi"
    "setup"
    "UsageApi"
  ];
in
{
  bookmarks = [
    {
      name = "Project (jira)";
      url = "https://jira.wolterskluwer.io/jira/browse/FIN-2989?jql=labels%20%3D%20capego-hybrid-integration";
    }
    {
      name = "Project (confluence)";
      url = "https://confluence.wolterskluwer.io/spaces/TAAEFINSIT/pages/939900705/Capego+hybrid+integration+MVP";
    }
    {
      name = "mergeable";
      url = "https://github.com/pulls/2270075?q=is%3Aopen+is%3Apr+archived%3Afalse+label%3Amergeable+user%3Aforetagsplatsen+";
    }
    {
      name = "mine";
      url = "https://github.com/pulls/authored";
    }
    {
      name = "reviews";
      url = "https://github.com/pulls/reviews";
    }
    {
      name = "Confluence / Jira";
      bookmarks = [
        {
          name = "finsit (confluence)";
          url = "https://confluence.wolterskluwer.io/spaces/TAAEFINSIT/pages/645662150/TAAE+Finsit";
        }
        {
          name = "Tickets of the current cycle";
          url = "https://jira.wolterskluwer.io/jira/secure/RapidBoard.jspa?rapidView=6800&view=planning&selectedIssue=FIN-908&epics=visible&issueLimit=100#";
        }
        {
          name = "Kanban";
          url = "https://jira.wolterskluwer.io/jira/secure/RapidBoard.jspa?rapidView=8506&view=detail&selectedIssue=FIN-3163#";
        }
        {
          name = "Bugs";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-80";
        }
        {
          name = "LHF";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-67";
        }
        {
          name = "Security";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-202";
        }
        {
          name = "My tasks";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-417?jql=project%20%3D%20FIN%20AND%20status%20in%20(Open%2C%20%22In%20Progress%22%2C%20Waiting%2C%20%22Pull%20Request%22)%20AND%20assignee%20in%20(currentUser())%20order%20by%20lastViewed%20DESC";
        }
        {
          name = "Tech debt finsit";
          url = "https://confluence.wolterskluwer.io/spaces/TAAEARC/pages/452000353/Tech+Debt+Finsit";
        }
      ];
    }
    {
      name = "Github";
      bookmarks =
        (map (repo: {
          name = repo;
          url = "https://github.com/foretagsplatsen/${repo}/pulls";
        }) repos)
        ++ [
          {
            name = "wktaasc-finsit-ai-tools";
            url = "https://github.com/wk-taa/wktaasc-finsit-ai-tools";
          }
        ];
    }
    {
      name = "FAB L3 Onboarding";
      url = "https://confluence.wolterskluwer.io/spaces/FOUNDATIONANDBEYOND/pages/1070897689/2026-05-22+Onboarding+FAB+Developer+Damien+Cassou";
    }
  ];
}
