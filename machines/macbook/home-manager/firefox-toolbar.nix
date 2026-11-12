_:
let
  capegoWebRepos = [
    "wktaasc-capegoweb-gitops"
    "wktaasc-capegoweb-reportingpbc-service"
    "wktaasc-capegoweb-specs"
    "wktaasc-capegoweb-ui"
    "wktaasc-common-actions"
  ];
  finsitRepos = [
    "wktaasc-finsit-actions"
    "wktaasc-finsit-ai-tools"
    "wktaasc-finsit-api-acceptance-tests"
    "wktaasc-finsit-api-lib"
    "wktaasc-finsit-audit-api"
    "wktaasc-finsit-computation-api"
    "wktaasc-finsit-frontend"
    "wktaasc-finsit-graphapi-lib"
    "wktaasc-finsit-import-api"
    "wktaasc-finsit-integration-api"
    "wktaasc-finsit-misc"
    "wktaasc-finsit-monitor"
    "wktaasc-finsit-public-api"
    "wktaasc-finsit-referential-api"
    "wktaasc-finsit-setup"
    "wktaasc-finsit-usage-api"
    "wktaasc-finsit-user-acceptance-tests"
  ];
  makeWkTaaGitHubBookmarks =
    repos:
    (map (repo: {
      name = repo;
      url = "https://github.com/wk-taa/${repo}/pulls";
    }) repos);
in
{
  bookmarks = [
    {
      name = "CW P&L/BS PDF";
      bookmarks = [
        {
          name = "Jira";
          url = "https://wk-dxg.atlassian.net/browse/FIN-3516";
        }
        {
          name = "Confluence";
          url = "https://wk-dxg.atlassian.net/wiki/spaces/TAAEFINSIT/pages/454992429/Capego+web+PDF+export+and+print";
        }
      ];
    }
    {
      name = "DevEx (Jira)";
      url = "https://wk-dxg.atlassian.net/browse/FIN-4635";
    }
    {
      name = "mergeable";
      url = "https://github.com/pulls/reviews?q=is%3Apr+state%3Aopen+archived%3Afalse+sort%3Aupdated-desc+label%3Amergeable+org%3Awk-taa";
    }
    {
      name = "mine";
      url = "https://github.com/pulls/authored";
    }
    {
      name = "reviews";
      url = "https://github.com/pulls/reviews?q=is%3Apr+review-requested%3A%40me+state%3Aopen+archived%3Afalse+sort%3Aupdated-desc+draft%3Afalse";
    }
    {
      name = "Confluence / Jira";
      bookmarks = [
        {
          name = "finsit (confluence)";
          url = "https://wk-dxg.atlassian.net/wiki/spaces/TAAEFINSIT/overview?homepageId=454950914";
        }
        {
          name = "Kanban";
          url = "https://wk-dxg.atlassian.net/secure/RapidBoard.jspa?rapidView=8506&view=detail&selectedIssue=FIN-3163#";
        }
        {
          name = "Bugs";
          url = "https://wk-dxg.atlassian.net/browse/FIN-80";
        }
        {
          name = "LHF";
          url = "https://wk-dxg.atlassian.net/browse/FIN-67";
        }
        {
          name = "Security";
          url = "https://wk-dxg.atlassian.net/browse/FIN-202";
        }
        {
          name = "My open LHF stories";
          url = "https://wk-dxg.atlassian.net/browse/FIN-598?jql=type%20in%20(Story)%20AND%20%22Epic%20Link%22%20in%20(FIN-67)%20AND%20reporter%20in%20(damien.cassou)%20AND%20status%20not%20in%20(Done)";
        }
        {
          name = "My tasks";
          url = "https://wk-dxg.atlassian.net/browse/FIN-4306?jql=project%20%3D%20FIN%20AND%20status%20in%20(Open%2C%20%22In%20Progress%22%2C%20Waiting%2C%20%22Pull%20Request%22)%20AND%20(assignee%20in%20(currentUser())%20OR%20labels%20in%20(DamienCassou))%20order%20by%20lastViewed%20DESC";
        }
        {
          name = "Tech debt Finsit";
          url = "https://wk-dxg.atlassian.net/wiki/spaces/TAAEARC/pages/378307608/Tech+Debt+Finsit";
        }
      ];
    }
    {
      name = "Github CW";
      bookmarks = makeWkTaaGitHubBookmarks capegoWebRepos;
    }
    {
      name = "Github finsit";
      bookmarks = makeWkTaaGitHubBookmarks finsitRepos;
    }
  ];
}
